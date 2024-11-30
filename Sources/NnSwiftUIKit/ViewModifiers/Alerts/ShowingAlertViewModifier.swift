//
//  ShowingAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that displays an alert in a SwiftUI view with a custom message and button text.
struct ShowingAlertViewModifier: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var presented: Bool
    
    /// The title of the alert.
    let title: String
    
    /// The message displayed in the alert.
    let message: String
    
    /// Information related to the alert's cancel button.
    let cancelInfo: AccessibleItemInfo
    
    /// An optional closure that is executed when the alert is dismissed.
    let finished: (() -> Void)?
    
    /// Modifies the content view to display an alert with the specified title, message, and button text.
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
