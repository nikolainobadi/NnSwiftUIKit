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

@available(iOS 15.0, *)
public extension View {
    func nnAsyncConfirmation(showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonText: String, message: String, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, role: role, buttonText: buttonText, message: message, action: action))
    }
}
