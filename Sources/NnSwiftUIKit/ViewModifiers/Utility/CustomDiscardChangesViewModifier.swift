//
//  CustomDiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import SwiftUI

/// A custom view modifier that displays a navigation bar dismiss button and a confirmation dialog
/// when changes are detected. Designed to prevent accidental dismissal when unsaved changes exist.
struct CustomDiscardChangesViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @State private var showingConfirmation = false
    
    let title: String
    let message: String
    let didMakeChanges: Bool
    let dismissButtonInfo: AccessibleItemInfo
    
    func body(content: Content) -> some View {
        content
            .nnWithNavBarDismissButton(isActive: didMakeChanges, dismissType: .cancel) {
                if didMakeChanges {
                    showingConfirmation = true
                } else {
                    dismiss()
                }
            }
            .confirmationDialog(title, isPresented: $showingConfirmation) {
                Button(dismissButtonInfo.prompt, role: .destructive) {
                    dismiss()
                }
            } message: {
                Text(message)
            }
    }
}

public extension View {
    /// Adds a custom navigation bar dismiss button to the view that shows a confirmation dialog
    /// when changes are detected, preventing accidental dismissal.
    ///
    /// - Parameters:
    ///   - title: The title of the confirmation dialog. Defaults to "Changes Detected".
    ///   - message: The message displayed in the confirmation dialog. Defaults to
    ///     "You've made changes to this item. Would you like to discard the changes?".
    ///   - didMakeChanges: A Boolean indicating whether changes have been made that require confirmation before dismissal.
    ///   - dismissButtonInfo: Information about the dismiss button in the confirmation dialog,
    ///     including an accessibility prompt. Defaults to `.init(prompt: "Discard Changes")`.
    /// - Returns: A view modified to include a custom navigation bar dismiss button with a confirmation dialog.
    func nnWithCustomDiscardChangesNavButton(_ title: String? = nil, message: String? = nil, didMakeChanges: Bool, dismissButtonInfo: AccessibleItemInfo? = nil) -> some View {
        modifier(
            CustomDiscardChangesViewModifier(
                title: title ?? "Changes Detected",
                message: message ?? "You've made changes to this item. Would you like to discard the changes?",
                didMakeChanges: didMakeChanges,
                dismissButtonInfo: dismissButtonInfo ?? .init(prompt: "Discard Changes")
            )
        )
    }
}
