//
//  CustomAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays a custom asynchronous alert in a SwiftUI view.
struct AsyncAlertViewModifier<AlertView: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let message: String
    let buttonInfo: AccessibleItemInfo
    let cancelInfo: AccessibleItemInfo
    let action: () async throws -> Void
    let cancelAction: () -> Void
    let alertView: () -> AlertView
    
    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented) {
                alertView()
                AsyncTryButton(buttonInfo.prompt, role: .destructive, action: action)
                    .setOptionalAccessibiltyId(buttonInfo.accessibilityId)
                
                Button(cancelInfo.prompt, role: .cancel, action: cancelAction)
                    .setOptionalAccessibiltyId(cancelInfo.accessibilityId)
            }
    }
}

public extension View {
    /// Displays a custom asynchronous alert with error handling.
    /// - Parameters:
    ///   - message: The message displayed in the alert.
    ///   - isPresented: A binding controlling the visibility of the alert.
    ///   - buttonInfo: Accessibility information for the action button.
    ///   - cancelInfo: Accessibility information for the cancel button.
    ///   - action: The asynchronous action to perform when the action button is tapped.
    ///   - cancelAction: The action to perform when the cancel button is tapped.
    ///   - alertView: The custom view content to be displayed within the alert.
    /// - Returns: A modified view that displays a custom asynchronous alert.
    func asyncAlert<AlertView: View>(_ message: String, isPresented: Binding<Bool>, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping () async throws -> Void, cancelAction: @escaping () -> Void = { }, @ViewBuilder alertView: @escaping () -> AlertView) -> some View {
        modifier(
            AsyncAlertViewModifier(
                isPresented: isPresented,
                message: message,
                buttonInfo: buttonInfo ?? .init(prompt: "Save", accessibilityId: nil),
                cancelInfo: cancelInfo ?? .init(prompt: "Cancel", accessibilityId: nil),
                action: action,
                cancelAction: cancelAction,
                alertView: alertView
            )
        )
    }
}
