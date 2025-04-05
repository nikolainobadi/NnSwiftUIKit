//
//  AsyncTaskOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that performs an asynchronous task when the view appears, with error handling and optional loading indicator.
struct AsyncTaskOnAppearViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let delay: Double
    let hideLoadingIndicator: Bool
    let asyncAction: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .delayedOnAppear(seconds: delay) {
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await asyncAction()
                    } catch {
                        await errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    /// Performs an asynchronous task with error handling when the view appears.
    /// - Parameters:
    ///   - delay: The delay in seconds before performing the action.
    ///   - hideLoadingIndicator: A Boolean indicating whether to hide the loading indicator during the task.
    ///   - asyncAction: The asynchronous action to perform on appear.
    /// - Returns: A modified view that performs an asynchronous task when it appears.
    func asyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
