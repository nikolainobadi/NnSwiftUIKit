//
//  ShowingAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct ShowingAlertViewModifier: ViewModifier {
    @Environment(\.showingAlertButtonInfo) private var environmentButtonInfo
    @Binding var presented: Bool

    let title: String
    let message: String
    let cancelInfo: AccessibleItemInfo?
    let finished: (() -> Void)?

    func body(content: Content) -> some View {
        let effectiveButtonInfo = cancelInfo ?? environmentButtonInfo

        content
            .alert(title, isPresented: $presented) {
                Button(effectiveButtonInfo.prompt, role: .cancel) {
                    finished?()
                }
                .keyboardShortcut(.defaultAction)
                .setOptionalAccessibiltyId(effectiveButtonInfo.accessibilityId)
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
    ///   - cancelInfo: Information about the alert's button. If `nil`, uses the environment value set via `.showingAlertButtonInfo(_:)` or `.showingAlertButtonPrompt(_:)`.
    ///   - isPresented: A binding controlling whether the alert is presented.
    ///   - finished: An optional closure executed when the alert is dismissed.
    /// - Returns: A modified view that shows an alert with the specified title and message.
    func showingAlert(
        _ title: String,
        message: String,
        cancelInfo: AccessibleItemInfo? = nil,
        isPresented: Binding<Bool>,
        finished: (() -> Void)? = nil
    ) -> some View {
        modifier(
            ShowingAlertViewModifier(
                presented: isPresented,
                title: title,
                message: message,
                cancelInfo: cancelInfo,
                finished: finished
            )
        )
    }
}
