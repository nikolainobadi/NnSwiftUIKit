//
//  FieldAlertViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays an asynchronous alert with a single text field in a SwiftUI view.
struct FieldAlertViewModifier: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var isPresented: Bool
    
    /// A state variable for the text in the field.
    @State private var fieldText = ""
    
    /// The message displayed in the alert.
    let message: String
    
    /// Information related to the text field's accessibility.
    let fieldInfo: AccessibleItemInfo
    
    /// Information related to the alert's action button.
    let buttonInfo: AccessibleItemInfo?
    
    /// Information related to the alert's cancel button.
    let cancelInfo: AccessibleItemInfo?
    
    /// The asynchronous action to perform when the action button is tapped.
    let action: (String) async throws -> Void
    
    /// Saves the input from the text field and performs the action.
    private func save() async throws {
        try await action(fieldText)
    }
    
    /// Modifies the content view to add an alert with a text field.
    func body(content: Content) -> some View {
        content
            .nnAsyncAlert(message, isPresented: $isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: save) {
                EmptyOnDisappearField(fieldInfo.prompt, text: $fieldText)
                    .nnSetAccessibiltyId(fieldInfo.accessibilityId)
            }
    }
}

public extension View {
    func nnFieldAlert(_ message: String, isPresented: Binding<Bool>, fieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String) async throws -> Void) -> some View {
        modifier(FieldAlertViewModifier(isPresented: isPresented, message: message, fieldInfo: fieldInfo, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: action))
    }
}
