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
    /// The original item before any modifications.
    @State private var originalItem: Item
    
    /// A state variable that controls whether the confirmation dialog is showing.
    @State private var showingConfirmation = false
    
    /// The dismiss action provided by the SwiftUI environment.
    @Environment(\.dismiss) private var dismiss
    
    /// The title of the confirmation dialog.
    let title: String
    
    /// The message displayed in the confirmation dialog.
    let message: String
    
    /// The item being modified, which is checked against the original item.
    let itemToModify: Item
    
    /// The placement of the dismiss button in the navigation bar.
    let placement: ToolbarItemPlacement
    
    /// The type of dismiss button (e.g., "xmark", "cancel", "done").
    let dismissType: NavBarDismissType
    
    /// The accessibility identifier for the dismiss button.
    let accessibilityId: String?
    
    /// The information related to the accessibility of the dismiss button.
    let dismissButtonInfo: AccessibleItemInfo
    
    /// Initializes a `DiscardChangesViewModifier` with the specified parameters.
    init(_ title: String?, itemToModify: Item, message: String?, placement: ToolbarItemPlacement?, dismissType: NavBarDismissType?, accessibilityId: String?, dismissButtonInfo: AccessibleItemInfo?) {
        self.title = title ?? "Changes Detected"
        self.message = message ?? "You've made changes to this item. Would you like to discard the changes?"
        self.itemToModify = itemToModify
        self.placement = placement ?? .topBarLeading
        self.dismissType = dismissType ?? .cancel
        self.accessibilityId = accessibilityId
        self.dismissButtonInfo = dismissButtonInfo ?? .init(prompt: "Discard Changes")
        self._originalItem = .init(wrappedValue: itemToModify)
    }
    
    /// Modifies the content view to add a navigation bar dismiss button with a confirmation dialog.
    func body(content: Content) -> some View {
        content
            .nnWithNavBarDismissButton(placement: placement, dismissType: dismissType, accessibilityId: accessibilityId) {
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
                .nnSetAccessibiltyId(dismissButtonInfo.accessibilityId)
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
    func nnWithDiscardChangesNavBarDismissButton<Item: Equatable>(_ title: String? = nil, message: String? = nil, itemToModify: Item, placement: ToolbarItemPlacement? = nil, dismissType: NavBarDismissType? = nil, accessibilityId: String? = nil, dismissButtonInfo: AccessibleItemInfo? = nil) -> some View {
        modifier(DiscardChangesViewModifier(title, itemToModify: itemToModify, message: message, placement: placement, dismissType: dismissType, accessibilityId: accessibilityId, dismissButtonInfo: dismissButtonInfo))
    }
}
#endif
