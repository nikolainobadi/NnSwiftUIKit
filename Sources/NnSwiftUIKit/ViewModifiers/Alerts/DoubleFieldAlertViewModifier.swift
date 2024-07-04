//
//  DoubleFieldAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DoubleFieldAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var firstFieldText = ""
    @State private var secondFieldText = ""
    
    let message: String
    let firstFieldPrompt: String
    let secondFieldPrompt: String
    let buttonText: String
    let cancelText: String
    let action: (String, String) async throws -> Void
    
    private func save() async throws {
        try await action(firstFieldText, secondFieldText)
    }
    
    func body(content: Content) -> some View {
        content
            .nnAsyncAlert(message, isPresented: $isPresented, action: save) {
                EmptyOnDisappearField(firstFieldPrompt, text: $firstFieldText)
                EmptyOnDisappearField(secondFieldPrompt, text: $secondFieldText)
            }
    }
}

