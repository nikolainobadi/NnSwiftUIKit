//
//  AsyncOpenURLViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that handles asynchronous actions triggered by opening a URL.
struct AsyncOpenURLViewModifier: ViewModifier {
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// Determines whether the loading indicator should be hidden.
    let hideLoadingIndicator: Bool
    
    /// The asynchronous action to perform when a URL is opened.
    let asyncAction: (URL) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onOpenURL { url in
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await asyncAction(url)
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    /// Attaches an asynchronous handler that is triggered when a URL is opened.
    /// - Parameters:
    ///   - hideLoadingIndicator: A Boolean value indicating whether to hide the loading indicator.
    ///   - asyncAction: The asynchronous action to perform when the URL is opened.
    /// - Returns: A modified view that handles URL opens asynchronously.
    func nnAsyncHandleURL(hideLoadingIndicator: Bool = false, asyncAction: @escaping (URL) async throws -> Void) -> some View {
        modifier(AsyncOpenURLViewModifier(hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
