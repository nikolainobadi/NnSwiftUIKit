//
//  CustomDiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

#if os(iOS)
import SwiftUI

struct CustomDiscardChangesViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @State private var showingConfirmation = false
    
    let title: String
    let message: String
    let placement: ToolbarItemPlacement
    let didMakeChanges: Bool
    let dismissType: NavBarDismissType
    let dismissButtonInfo: AccessibleItemInfo
    
    func body(content: Content) -> some View {
        content
            .withNavBarDismissButton(dismissType: dismissType) {
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
                .setOptionalAccessibiltyId(dismissButtonInfo.accessibilityId)
            } message: {
                Text(message)
            }
    }
}

public extension View {
    /// Adds a navigation bar dismiss button with manual change tracking and confirmation dialog.
    ///
    /// **iOS only.** This is the base implementation that requires manual change tracking via the
    /// `didMakeChanges` parameter. For automatic change tracking based on an Equatable item, use
    /// the overload that accepts an `itemToModify` parameter instead.
    ///
    /// - Parameters:
    ///   - title: The title of the confirmation dialog. Defaults to "Changes Detected".
    ///   - message: The message displayed in the confirmation dialog. Defaults to "You've made changes to this item. Would you like to discard the changes?".
    ///   - placement: The placement of the dismiss button in the navigation bar. Defaults to `.topBarLeading`.
    ///   - didMakeChanges: A Boolean indicating whether changes have been made. You are responsible for tracking this state.
    ///   - dismissType: The type of dismiss button (e.g., `.cancel`, `.xmark`, `.done`). Defaults to `.cancel`.
    ///   - dismissButtonInfo: Accessibility information for the "Discard Changes" button in the confirmation dialog. Defaults to `.init(prompt: "Discard Changes")`.
    /// - Returns: A modified view with a dismiss button that prompts a confirmation dialog when `didMakeChanges` is true.
    func withDiscardChangesNavBarDismissButton(
        _ title: String? = nil,
        message: String? = nil,
        placement: ToolbarItemPlacement? = nil,
        didMakeChanges: Bool,
        dismissType: NavBarDismissType? = nil,
        dismissButtonInfo: AccessibleItemInfo? = nil
    ) -> some View {
        modifier(
            CustomDiscardChangesViewModifier(
                title: title ?? "Changes Detected",
                message: message ?? "You've made changes to this item. Would you like to discard the changes?",
                placement: placement ?? .topBarLeading,
                didMakeChanges: didMakeChanges,
                dismissType: dismissType ?? .cancel,
                dismissButtonInfo: dismissButtonInfo ?? .init(prompt: "Discard Changes")
            )
        )
    }
}
#endif
