//
//  FieldAlertViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

struct FieldAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var fieldText = ""

    let message: String
    let hideLoadingIndicator: Bool
    let fieldInfo: AccessibleItemInfo
    let buttonInfo: AccessibleItemInfo?
    let cancelInfo: AccessibleItemInfo?
    let action: (String) async throws -> Void
    
    private func save() async throws {
        try await action(fieldText)
    }
    
    private func clearField() {
        fieldText = ""
    }
    
    func body(content: Content) -> some View {
        content
            .asyncAlert(message, isPresented: $isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: save, cancelAction: clearField) {
                TextField(fieldInfo.prompt, text: $fieldText)
                    .setOptionalAccessibiltyId(fieldInfo.accessibilityId)
            }
    }
}

public extension View {
    /// Displays an asynchronous alert with a single text field.
    /// - Parameters:
    ///   - message: The message displayed in the alert.
    ///   - isPresented: A binding controlling the alert’s presentation.
    ///   - fieldInfo: Accessibility information for the text field.
    ///   - buttonInfo: Accessibility information for the action button.
    ///   - cancelInfo: Accessibility information for the cancel button.
    ///   - action: The asynchronous action to perform using the input from the text field.
    /// - Returns: A modified view with an alert containing a single text field.
    func singleFieldAlert(
        _ message: String,
        isPresented: Binding<Bool>,
        fieldInfo: AccessibleItemInfo,
        buttonInfo: AccessibleItemInfo? = nil,
        cancelInfo: AccessibleItemInfo? = nil,
        hideLoadingIndicator: Bool = false,
        action: @escaping (String) async throws -> Void
    ) -> some View {
        modifier(
            FieldAlertViewModifier(
                isPresented: isPresented,
                message: message,
                hideLoadingIndicator: hideLoadingIndicator,
                fieldInfo: fieldInfo,
                buttonInfo: buttonInfo,
                cancelInfo: cancelInfo,
                action: action
            )
        )
    }
}
