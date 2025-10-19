//
//  DeleteRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

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
        if isActive {
            content
                .swipeActions {
                    Button(action: { showingConfirmation = true }) {
                        Label(swipeButtonInfo.text, systemImage: swipeButtonInfo.systemImage)
                    }
                    .tint(swipeButtonTint)
                    .setOptionalAccessibiltyId(swipeButtonInfo.accessibilityId)
                }
                .confirmationDialog("", isPresented: $showingConfirmation) {
                    AsyncTryButton(alertButtonInfo.prompt, role: swipeButtonRole, action: delete)
                        .setOptionalAccessibiltyId(alertButtonInfo.accessibilityId)
                } message: {
                    Text(message)
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Adds a swipe-to-delete action with optional confirmation and async error handling.
    ///
    /// This modifier conditionally applies a `.swipeActions` and `.confirmationDialog` pair
    /// based on `isActive`. Because SwiftUI reconstructs the view hierarchy when modifier
    /// chains differ, toggling `isActive` can lead to unexpected reinitialization or
    /// state loss for any views that maintain internal state or bindings.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**. For stateful views, prefer keeping
    /// a consistent `.swipeActions` modifier and dynamically disabling it instead of removing it.
    ///
    /// When active, this modifier provides:
    /// - A swipe action button (configured via `swipeButtonInfo`).
    /// - An optional confirmation dialog (controlled by `skipConfirmation`).
    /// - An async delete action executed via `AsyncTryButton`, which automatically handles
    ///   thrown errors and integrates with accessibility identifiers for testing and UI automation.
    ///
    /// - Parameters:
    ///   - message: The confirmation message shown before deletion. Defaults to `"Are you sure you want to delete this item?"`.
    ///   - isActive: A Boolean controlling whether the swipe action and confirmation are applied. Defaults to `true`.
    ///   - skipConfirmation: A Boolean determining whether to skip the confirmation dialog and delete immediately.
    ///   - swipeButtonTint: The tint color applied to the swipe button. Defaults to `.red`.
    ///   - swipeButtonRole: The button role (e.g. `.destructive`) used in the confirmation dialog. Defaults to `.destructive`.
    ///   - swipeButtonInfo: Optional metadata describing the swipe button’s label and accessibility identifier. Defaults to a red trash icon labeled “Delete”.
    ///   - alertButtonInfo: Optional metadata describing the confirmation button’s prompt and accessibility identifier. Defaults to “Delete”.
    ///   - delete: The async action executed when deletion is confirmed or triggered.
    /// - Returns: A modified view that enables swipe-to-delete with optional confirmation and async error handling.
    func withSwipeDelete(
        message: String = "Are you sure you want to delete this item?",
        isActive: Bool = true,
        skipConfirmation: Bool = false,
        swipeButtonTint: Color = .red,
        swipeButtonRole: ButtonRole? = .destructive,
        swipeButtonInfo: AccessibleLabelInfo? = nil,
        alertButtonInfo: AccessibleItemInfo? = nil,
        delete: @escaping () async throws -> Void
    ) -> some View {
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
