//
//  ShowingAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that displays an alert in a SwiftUI view with a custom message and button text.
struct ShowingAlertViewModifier: ViewModifier {
    @Binding var presented: Bool
    
    let title: String
    let message: String
    let cancelInfo: AccessibleItemInfo
    let finished: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $presented) {
                Button(cancelInfo.prompt, role: .cancel) {
                    finished?()
                }
                .setOptionalAccessibiltyId(cancelInfo.accessibilityId)
            } message: {
                Text(message)
            }
    }
}

public extension View {
    /// Displays an alert with a custom message and button text.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to display in the alert.
    ///   - cancelInfo: Information about the alert’s cancel button.
    ///   - isPresented: A binding controlling whether the alert is presented.
    ///   - finished: An optional closure executed when the alert is dismissed.
    /// - Returns: A modified view that shows an alert with the specified title and message.
    func showingAlert(_ title: String, message: String, cancelInfo: AccessibleItemInfo? = nil, isPresented: Binding<Bool>, finished: (() -> Void)? = nil) -> some View {
        modifier(ShowingAlertViewModifier(presented: isPresented, title: title, message: message, cancelInfo: cancelInfo ?? .init(prompt: "Okay"), finished: finished))
    }
}
