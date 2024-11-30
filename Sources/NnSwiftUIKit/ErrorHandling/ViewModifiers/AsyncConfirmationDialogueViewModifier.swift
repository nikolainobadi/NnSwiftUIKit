//
//  AsyncConfirmationDialogueViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that displays an asynchronous confirmation dialog in SwiftUI with error handling.
struct AsyncConfirmationDialogueViewModifier: ViewModifier {
    /// A binding that controls whether the confirmation dialog is showing.
    @Binding var showingConfirmation: Bool
    
    /// The role of the button in the confirmation dialog (e.g., destructive, cancel).
    let role: ButtonRole?
    
    /// Information related to the accessibility of the dialog's button.
    let buttonInfo: AccessibleItemInfo
    
    /// The message displayed in the confirmation dialog.
    let message: String
    
    /// The asynchronous action to perform upon confirmation.
    let action: () async throws -> Void
    
    /// Modifies the content view to include an asynchronous confirmation dialog with error handling.
    func body(content: Content) -> some View {
        content
            .confirmationDialog("", isPresented: $showingConfirmation) {
                AsyncTryButton(buttonInfo.prompt, role: role, action: action)
                    .setOptionalAccessibiltyId(buttonInfo.accessibilityId)
            } message: {
                Text(message)
            }
    }
}

public extension View {
    /// Displays an asynchronous confirmation dialog with error handling.
    /// - Parameters:
    ///   - showingConfirmation: A binding controlling the visibility of the confirmation dialog.
    ///   - role: The role of the dialog button, such as destructive or cancel.
    ///   - buttonInfo: Accessibility information for the dialog's button.
    ///   - message: The confirmation message to display.
    ///   - action: The asynchronous action to perform upon confirmation.
    /// - Returns: A modified view with an asynchronous confirmation dialog.
    func asyncConfirmation(showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonInfo: AccessibleItemInfo, message: String, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, role: role, buttonInfo: buttonInfo, message: message, action: action))
    }
}
