//
//  FieldAlertViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct FieldAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var fieldText = ""
    
    let message: String
    let fieldPrompt: String
    let buttonText: String
    let cancelText: String
    let action: (String) async throws -> Void
    
    private func save() async throws {
        try await action(fieldText)
    }
    
    func body(content: Content) -> some View {
        content
            .nnAsyncAlert(message, isPresented: $isPresented, action: save) {
                EmptyOnDisappearField(fieldPrompt, text: $fieldText)
            }
    }
}
