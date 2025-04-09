//
//  DoubleFieldAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays an asynchronous alert with two text fields in a SwiftUI view.
struct DoubleFieldAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var firstFieldText = ""
    @State private var secondFieldText = ""
    
    let message: String
    let firstFieldInfo: AccessibleItemInfo
    let secondFieldInfo: AccessibleItemInfo
    let buttonInfo: AccessibleItemInfo?
    let cancelInfo: AccessibleItemInfo?
    let hideLoadingIndicator: Bool
    let action: (String, String) async throws -> Void
    
    private func save() async throws {
        try await action(firstFieldText, secondFieldText)
        clearFields()
    }
    
    private func clearFields() {
        firstFieldText = ""
        secondFieldText = ""
    }
    
    func body(content: Content) -> some View {
        content
            .asyncAlert(message, isPresented: $isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, hideLoadingIndicator: hideLoadingIndicator, action: save, cancelAction: clearFields) {
                TextField(firstFieldInfo.prompt, text: $firstFieldText)
                    .setOptionalAccessibiltyId(firstFieldInfo.accessibilityId)
                TextField(secondFieldInfo.prompt, text: $secondFieldText)
                    .setOptionalAccessibiltyId(secondFieldInfo.accessibilityId)
            }
    }
}

public extension View {
    /// Displays an asynchronous alert with two text fields.
    /// - Parameters:
    ///   - message: The message displayed in the alert.
    ///   - isPresented: A binding controlling whether the alert is shown.
    ///   - firstFieldInfo: Accessibility information for the first text field.
    ///   - secondFieldInfo: Accessibility information for the second text field.
    ///   - buttonInfo: Accessibility information for the action button.
    ///   - cancelInfo: Accessibility information for the cancel button.
    ///   - action: The asynchronous action to perform using the text from both fields.
    /// - Returns: A modified view with an alert containing two text fields.
    func doubleFieldAlert(_ message: String, isPresented: Binding<Bool>, firstFieldInfo: AccessibleItemInfo, secondFieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, hideLoadingIndicator: Bool = false, action: @escaping (String, String) async throws -> Void) -> some View {
        modifier(
            DoubleFieldAlertViewModifier(
                isPresented: isPresented,
                message: message,
                firstFieldInfo: firstFieldInfo,
                secondFieldInfo: secondFieldInfo,
                buttonInfo: buttonInfo,
                cancelInfo: cancelInfo,
                hideLoadingIndicator: hideLoadingIndicator,
                action: action
            )
        )
    }
}
