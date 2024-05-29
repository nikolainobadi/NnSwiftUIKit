//
//  DeleteRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DeleteRowViewModifier: ViewModifier {
    @State private var showingConfirmation = false
    
    let message: String
    let isActive: Bool
    let buttonImage: String
    let deleteText: String
    let delete: () async throws -> Void
    
    public func body(content: Content) -> some View {
        if isActive {
            content
                .swipeActions {
                    Button(action: { showingConfirmation = true }) {
                        Label("Delete", systemImage: buttonImage)
                    }
                    .tint(.red)
                }
                .nnAsyncConfirmation(showingConfirmation: $showingConfirmation, role: .destructive, buttonText: deleteText, message: message, action: delete)
        } else {
            content
        }
    }
}
