//
//  DeleteRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that adds a swipe-to-delete action to a SwiftUI view with confirmation and error handling.
struct DeleteRowViewModifier: ViewModifier {
    @State private var showingConfirmation = false
    
    let message: String
    let isActive: Bool
    let alertButtonInfo: AccessibleItemInfo
    let delete: () async throws -> Void
    
    public func body(content: Content) -> some View {
        content
            .showingConditionalView(when: isActive) {
                content
                    .swipeActions {
                        Button(action: { showingConfirmation = true }) {
                            Label("Delete", systemImage: "trash")
                            // TODO: - apply accessibility
                        }
                        .tint(.red)
                    }
                    .asyncConfirmation(showingConfirmation: $showingConfirmation, role: .destructive, buttonInfo: alertButtonInfo, message: message, action: delete)
            }
    }
}

public extension View {
    /// Adds a swipe-to-delete action with confirmation and error handling.
    /// - Parameters:
    ///   - message: The confirmation message to display in the dialog.
    ///   - isActive: A Boolean value indicating whether the delete action is active.
    ///   - alertButtonInfo: Accessibility information for the alert button.
    ///   - delete: The asynchronous action to perform upon deletion confirmation.
    /// - Returns: A modified view with swipe-to-delete functionality.
    func withSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, alertButtonInfo: AccessibleItemInfo? = nil, delete: @escaping () async throws -> Void) -> some View {
        modifier(DeleteRowViewModifier(message: message, isActive: isActive, alertButtonInfo: alertButtonInfo ?? .init(prompt: "Delete"), delete: delete))
    }
}
