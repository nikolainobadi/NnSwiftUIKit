//
//  AsyncConfirmationDialogueViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct AsyncConfirmationDialogueViewModifier: ViewModifier {
    @Binding var showingConfirmation: Bool
    
    let isActive: Bool
    let message: String
    let role: ButtonRole?
    let buttonInfo: AccessibleItemInfo
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .confirmationDialog("", isPresented: $showingConfirmation) {
                    AsyncTryButton(buttonInfo.prompt, role: role, action: action)
                        .setOptionalAccessibiltyId(buttonInfo.accessibilityId)
                } message: {
                    Text(message)
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Presents an asynchronous confirmation dialog that executes an async action when confirmed.
    ///
    /// This modifier conditionally attaches a `.confirmationDialog` presentation to the view based on `isActive`.
    /// Because SwiftUI rebuilds views when modifier chains differ, toggling `isActive` can lead to view reinitialization,
    /// state loss, or unexpected resets in the hierarchy — particularly when the base view or its children manage state.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**. For stateful views, prefer maintaining a stable
    /// `.confirmationDialog` and controlling its visibility solely through the provided `showingConfirmation` binding.
    ///
    /// The confirmation dialog includes an `AsyncTryButton`, which safely handles asynchronous operations
    /// with built-in error management and optional accessibility identifiers.
    ///
    /// - Parameters:
    ///   - showingConfirmation: A binding controlling whether the confirmation dialog is presented.
    ///   - isActive: A Boolean controlling whether the modifier is applied. Defaults to `true`.
    ///   - message: The confirmation message displayed in the dialog.
    ///   - role: An optional `ButtonRole` defining the button’s visual emphasis (e.g., `.destructive` or `.cancel`).
    ///   - buttonInfo: Metadata describing the confirmation button’s label and accessibility identifier.
    ///   - action: The asynchronous action to perform when the confirmation button is tapped.
    /// - Returns: A modified view that displays an async-enabled confirmation dialog when active.
    func asyncConfirmation(
        showingConfirmation: Binding<Bool>,
        isActive: Bool = true,
        message: String,
        role: ButtonRole? = nil,
        buttonInfo: AccessibleItemInfo,
        action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            AsyncConfirmationDialogueViewModifier(
                showingConfirmation: showingConfirmation,
                isActive: isActive,
                message: message,
                role: role,
                buttonInfo: buttonInfo,
                action: action
            )
        )
    }
}
