//
//  AsyncConfirmationDialogueViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct AsyncConfirmationDialogueViewModifier: ViewModifier {
    @Binding var showingConfirmation: Bool
    
    let role: ButtonRole?
    let buttonText: String
    let message: String
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .confirmationDialog("", isPresented: $showingConfirmation) {
                NnAsyncTryButton(buttonText, role: role?.nnButtonRole, action: action)
            } message: {
                Text(message)
            }
    }
}
