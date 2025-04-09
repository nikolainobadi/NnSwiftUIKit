//
//  AsyncTryOnSubmitViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that adds asynchronous error-handling functionality to the onSubmit action in SwiftUI.
struct AsyncTryOnSubmitViewModifier: ViewModifier {
    @EnvironmentObject var context: NnErrorHandlingContext
    
    let submitLabel: SubmitLabel
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .submitLabel(submitLabel)
            .onSubmit {
                context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
            }
    }
}

public extension View {
    /// Adds asynchronous error-handling to the onSubmit action in a SwiftUI view.
    /// - Parameters:
    ///   - submitLabel: The label to display for the submit button.
    ///   - action: The asynchronous action to perform when the submit button is pressed.
    /// - Returns: A modified view with error-handling for submit actions.
    func asyncOnSubmit(submitLabel: SubmitLabel = .done, hideLoadingIndicator: Bool = false, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryOnSubmitViewModifier(submitLabel: submitLabel, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
