//
//  AsyncOpenURLViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct AsyncOpenURLViewModifier: ViewModifier {
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let hideLoadingIndicator: Bool
    let asyncAction: (URL) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onOpenURL { url in
                context.performAction(hideLoadingIndicator: hideLoadingIndicator) {
                    try await asyncAction(url)
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
    func asyncHandleURL(hideLoadingIndicator: Bool = false, asyncAction: @escaping (URL) async throws -> Void) -> some View {
        modifier(AsyncOpenURLViewModifier(hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
