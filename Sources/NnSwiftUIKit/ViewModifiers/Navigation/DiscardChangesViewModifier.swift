//
//  DiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/14/24.
//

#if canImport(UIKit)
import SwiftUI

@available(iOS 15.0, *)
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
    let dismissButtonInfo: AccessibleItemInfo
    
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
#endif
