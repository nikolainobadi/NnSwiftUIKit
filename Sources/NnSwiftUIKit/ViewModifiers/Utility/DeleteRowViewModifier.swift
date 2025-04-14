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
    let skipConfirmation: Bool
    let swipeButtonTint: Color
    let swipeButtonRole: ButtonRole?
    let alertButtonInfo: AccessibleItemInfo
    let swipeButtonInfo: AccessibleLabelInfo
    let delete: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .showingConditionalView(when: isActive) {
                content
                    .swipeActions {
                        Button(action: { showingConfirmation = true }) {
                            Label(swipeButtonInfo.text, systemImage: swipeButtonInfo.systemImage)
                                .setOptionalAccessibiltyId(swipeButtonInfo.accessibilityId)
                        }
                        .tint(swipeButtonTint)
                    }
                    .asyncConfirmation(showingConfirmation: $showingConfirmation, isActive: isActive, message: message, role: swipeButtonRole, buttonInfo: alertButtonInfo, action: delete)
            }
    }
}

public extension View {
    func withSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, skipConfirmation: Bool = false, swipeButtonTint: Color = .red, swipeButtonRole: ButtonRole? = .destructive, swipeButtonInfo: AccessibleLabelInfo? = nil, alertButtonInfo: AccessibleItemInfo? = nil, delete: @escaping () async throws -> Void) -> some View {
        modifier(
            DeleteRowViewModifier(
                message: message,
                isActive: isActive,
                skipConfirmation: skipConfirmation,
                swipeButtonTint: swipeButtonTint,
                swipeButtonRole: swipeButtonRole,
                alertButtonInfo: alertButtonInfo ?? .init(prompt: "Delete"),
                swipeButtonInfo: swipeButtonInfo ?? .init(text: "Delete", systemImage: "trash"),
                delete: delete
            )
        )
    }
}
