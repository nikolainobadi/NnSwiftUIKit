//
//  DiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/14/24.
//

#if canImport(UIKit)
import SwiftUI

/// A view modifier that adds a navigation bar dismiss button with a confirmation dialog for discarding changes in a SwiftUI view.
struct DiscardChangesViewModifier<Item: Equatable>: ViewModifier {
    @State private var originalItem: Item
    @State private var showingConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let message: String
    let itemToModify: Item
    let placement: ToolbarItemPlacement
    let dismissType: NavBarDismissType
    let accessibilityId: String?
    let buttonTextColor: Color
    let dismissButtonInfo: AccessibleItemInfo
    
    /// Initializes a `DiscardChangesViewModifier` with the specified parameters.
    init(_ title: String?, itemToModify: Item, message: String?, placement: ToolbarItemPlacement?, dismissType: NavBarDismissType?, buttonTextColor: Color, accessibilityId: String?, dismissButtonInfo: AccessibleItemInfo?) {
        self.title = title ?? "Changes Detected"
        self.message = message ?? "You've made changes to this item. Would you like to discard the changes?"
        self.itemToModify = itemToModify
        self.placement = placement ?? .topBarLeading
        self.dismissType = dismissType ?? .cancel
        self.buttonTextColor = buttonTextColor
        self.accessibilityId = accessibilityId
        self.dismissButtonInfo = dismissButtonInfo ?? .init(prompt: "Discard Changes")
        self._originalItem = .init(wrappedValue: itemToModify)
    }
    
    func body(content: Content) -> some View {
        content
            .withNavBarDismissButton(placement: placement, textColor: buttonTextColor, dismissType: dismissType, accessibilityId: accessibilityId) {
                if itemToModify != originalItem {
                    showingConfirmation = true
                } else {
                    dismiss()
                }
            }
            .confirmationDialog("Changes Detected", isPresented: $showingConfirmation) {
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
    /// Adds a navigation bar dismiss button with a confirmation dialog for discarding changes.
    /// - Parameters:
    ///   - title: The title of the confirmation dialog.
    ///   - message: The message displayed in the confirmation dialog.
    ///   - itemToModify: The item being modified, which is compared to its original state.
    ///   - placement: The placement of the dismiss button in the navigation bar.
    ///   - dismissType: The type of dismiss button (e.g., "xmark", "cancel", "done").
    ///   - accessibilityId: The accessibility identifier for the dismiss button.
    ///   - dismissButtonInfo: Accessibility information for the dismiss button.
    /// - Returns: A modified view with a dismiss button that prompts a confirmation dialog if there are changes.
    func withDiscardChangesNavBarDismissButton<Item: Equatable>(_ title: String? = nil, message: String? = nil, itemToModify: Item, placement: ToolbarItemPlacement? = nil, dismissType: NavBarDismissType? = nil, buttonTextColor: Color = .primary, accessibilityId: String? = nil, dismissButtonInfo: AccessibleItemInfo? = nil) -> some View {
        modifier(DiscardChangesViewModifier(title, itemToModify: itemToModify, message: message, placement: placement, dismissType: dismissType, buttonTextColor: buttonTextColor, accessibilityId: accessibilityId, dismissButtonInfo: dismissButtonInfo))
    }
}
#endif
