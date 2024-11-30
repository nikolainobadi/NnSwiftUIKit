//
//  CustomAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays a custom asynchronous alert in a SwiftUI view.
struct AsyncAlertViewModifier<AlertView: View>: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var isPresented: Bool
    
    /// The message displayed in the alert.
    let message: String
    
    /// Information related to the alert's action button.
    let buttonInfo: AccessibleItemInfo
    
    /// Information related to the alert's cancel button.
    let cancelInfo: AccessibleItemInfo
    
    /// The asynchronous action to perform when the action button is tapped.
    let action: () async throws -> Void
    
    /// The action to perform when the cancel button is tapped.
    let cancelAction: () -> Void
    
    /// The custom view content to be displayed within the alert.
    let alertView: () -> AlertView
    
    /// Modifies the content view to display a custom asynchronous alert.
    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented) {
                alertView()
                AsyncTryButton(buttonInfo.prompt, role: .destructive, action: action)
                    .setAccessibiltyId(buttonInfo.accessibilityId)
                
                Button(cancelInfo.prompt, role: .cancel, action: cancelAction)
                    .setAccessibiltyId(cancelInfo.accessibilityId)
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
