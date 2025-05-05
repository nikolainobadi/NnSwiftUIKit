//
//  AsyncConfirmationDialogueViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that displays an asynchronous confirmation dialog in SwiftUI with error handling.
struct AsyncConfirmationDialogueViewModifier: ViewModifier {
    @Binding var showingConfirmation: Bool
    
    let isActive: Bool
    let message: String
    let role: ButtonRole?
    let buttonInfo: AccessibleItemInfo
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .confirmationDialog("", isPresented: $showingConfirmation) {
                    AsyncTryButton(buttonInfo.prompt, role: role, action: action)
                        .setOptionalAccessibiltyId(buttonInfo.accessibilityId)
                } message: {
                    Text(message)
                }
        } else {
            content
        }
    }
}

public extension View {
    func asyncConfirmation(showingConfirmation: Binding<Bool>, isActive: Bool = true,  message: String, role: ButtonRole? = nil, buttonInfo: AccessibleItemInfo, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, isActive: isActive, message: message, role: role, buttonInfo: buttonInfo, action: action))
    }
}
