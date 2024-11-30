//
//  AsyncTryOnSubmitViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that adds asynchronous error-handling functionality to the onSubmit action in SwiftUI.
struct AsyncTryOnSubmitViewModifier: ViewModifier {
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// The label for the submit button.
    let submitLabel: SubmitLabel
    
    /// The asynchronous action that is performed when the submit button is pressed.
    let action: () async throws -> Void
    
    /// Modifies the content view to handle asynchronous submit actions.
    func body(content: Content) -> some View {
        content
            .submitLabel(submitLabel)
            .onSubmit {
                Task {
                    loadingHandler.startLoading()
                    
                    do {
                        try await action()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading()
                }
            }
    }
}

public extension View {
    /// Adds asynchronous error-handling to the onSubmit action in a SwiftUI view.
    /// - Parameters:
    ///   - submitLabel: The label to display for the submit button.
    ///   - action: The asynchronous action to perform when the submit button is pressed.
    /// - Returns: A modified view with error-handling for submit actions.
    func asyncOnSubmit(submitLabel: SubmitLabel = .done, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryOnSubmitViewModifier(submitLabel: submitLabel, action: action))
    }
}
