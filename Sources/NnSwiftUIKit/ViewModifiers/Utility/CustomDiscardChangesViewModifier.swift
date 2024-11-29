//
//  CustomDiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import SwiftUI

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
    func nnWithCustomDiscardChangesNavButton(_ title: String = "Changes Detected", message: String = "You've made changes to this item. Would you like to discard the changes?", didMakeChanges: Bool, dismissButtonInfo: AccessibleItemInfo = .init(prompt: "Discard Changes")) -> some View {
        modifier(CustomDiscardChangesViewModifier(title: title, message: message, didMakeChanges: didMakeChanges, dismissButtonInfo: dismissButtonInfo))
    }
}
