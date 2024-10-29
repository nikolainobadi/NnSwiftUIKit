//
//  AsyncTaskOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that performs an asynchronous task when the view appears, with error handling and optional loading indicator.
struct AsyncTaskOnAppearViewModifier: ViewModifier {
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// The delay before the asynchronous action is performed, in seconds.
    let delay: Double
    
    /// Indicates whether the loading indicator should be hidden during the task.
    let hideLoadingIndicator: Bool
    
    /// The asynchronous action to perform when the view appears.
    let asyncAction: () async throws -> Void
    
    /// Modifies the content view to perform an asynchronous action on appear.
    func body(content: Content) -> some View {
        content
            .nnDelayedOnAppear(seconds: delay) {
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await asyncAction()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    func nnAsyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
