//
//  DoubleFieldAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays an asynchronous alert with two text fields in a SwiftUI view.
struct DoubleFieldAlertViewModifier: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var isPresented: Bool
    
    /// A state variable for the text in the first field.
    @State private var firstFieldText = ""
    
    /// A state variable for the text in the second field.
    @State private var secondFieldText = ""
    
    /// The message displayed in the alert.
    let message: String
    
    /// Information related to the first text field's accessibility.
    let firstFieldInfo: AccessibleItemInfo
    
    /// Information related to the second text field's accessibility.
    let secondFieldInfo: AccessibleItemInfo
    
    /// Information related to the alert's action button.
    let buttonInfo: AccessibleItemInfo?
    
    /// Information related to the alert's cancel button.
    let cancelInfo: AccessibleItemInfo?
    
    /// The asynchronous action to perform when the action button is tapped.
    let action: (String, String) async throws -> Void
    
    /// Saves the input from the two text fields and performs the action.
    private func save() async throws {
        try await action(firstFieldText, secondFieldText)
    }
    
    /// Modifies the content view to add an alert with two text fields.
    func body(content: Content) -> some View {
        content
            .asyncAlert(message, isPresented: $isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: save) {
                EmptyOnDisappearField(firstFieldInfo.prompt, text: $firstFieldText)
                    .setAccessibiltyId(firstFieldInfo.accessibilityId)
                EmptyOnDisappearField(secondFieldInfo.prompt, text: $secondFieldText)
                    .setAccessibiltyId(secondFieldInfo.accessibilityId)
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
    func doubleFieldAlert(_ message: String, isPresented: Binding<Bool>, firstFieldInfo: AccessibleItemInfo, secondFieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String, String) async throws -> Void) -> some View {
        modifier(
            DoubleFieldAlertViewModifier(
                isPresented: isPresented,
                message: message,
                firstFieldInfo: firstFieldInfo,
                secondFieldInfo: secondFieldInfo,
                buttonInfo: buttonInfo,
                cancelInfo: cancelInfo,
                action: action
            )
        )
    }
}
