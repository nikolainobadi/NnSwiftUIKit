//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DiscardChangesViewModifier<Item: Equatable>: ViewModifier {
    @State private var originalItem: Item
    @State private var showingConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let message: String
    let buttonText: String
    let itemToModify: Item
    let placement: ToolbarItemPlacement
    let dismissType: NavBarDismissType
    
    init(_ title: String?, itemToModify: Item, message: String?, buttonText: String?, placement: ToolbarItemPlacement?, dismissType: NavBarDismissType?) {
        self.title = title ?? "Changes Detected"
        self.message = message ?? "You've made changes to this item. Would you like to discard the changes?"
        self.buttonText = buttonText ?? "Discard Changes"
        self.itemToModify = itemToModify
        self.placement = placement ?? .topBarLeading
        self.dismissType = dismissType ?? .cancel
        self._originalItem = .init(wrappedValue: itemToModify)
    }
    
    func body(content: Content) -> some View {
        content
            .nnWithNavBarDismissButton(placement: placement, dismissType: dismissType) {
                if itemToModify != originalItem {
                    showingConfirmation = true
                } else {
                    dismiss()
                }
            }
            .confirmationDialog("Changes Detected", isPresented: $showingConfirmation) {
                Button(buttonText, role: .destructive) {
                    dismiss()
                }
            } message: {
                Text(message)
            }
    }
}
