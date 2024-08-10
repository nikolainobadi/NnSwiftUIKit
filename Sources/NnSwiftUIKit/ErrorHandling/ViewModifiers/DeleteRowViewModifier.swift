//
//  DeleteRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that adds a swipe-to-delete action to a SwiftUI view with confirmation and error handling.
@available(iOS 15.0, *)
struct DeleteRowViewModifier: ViewModifier {
    /// Indicates whether the confirmation dialog should be shown.
    @State private var showingConfirmation = false
    
    /// The message displayed in the confirmation dialog.
    let message: String
    
    /// Indicates whether the swipe-to-delete action is active.
    let isActive: Bool
    
    /// The information related to the accessibility of the alert button.
    let alertButtonInfo: AccessibleItemInfo
    
    /// The asynchronous delete action that is performed upon confirmation.
    let delete: () async throws -> Void
    
    /// Modifies the content view to include swipe-to-delete functionality.
    public func body(content: Content) -> some View {
        if isActive {
            content
                .swipeActions {
                    Button(action: { showingConfirmation = true }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
                .nnAsyncConfirmation(showingConfirmation: $showingConfirmation, role: .destructive, buttonInfo: alertButtonInfo, message: message, action: delete)
        } else {
            content
        }
    }
}
