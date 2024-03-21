//
//  AsyncTextFieldAlertViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct AsyncTextFieldAlertViewModifier: ViewModifier {
    @State private var text = ""
    @Binding var isPresented: Bool
    
    let title: String
    let prompt: String
    let message: String
    let keyboardType: UIKeyboardType
    let actionButtonText: String
    let saveAction: (String) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented, actions: {
                TextField(prompt, text: $text)
                    .keyboardType(keyboardType)
                NnAsyncTryButton(actionButtonText, role: .destructive, action: {
                    try await saveAction(text)
                    await MainActor.run {
                        text = ""
                    }
                })
            }, message: {
                Text(message)
            })
    }
}


@available(iOS 15.0, *)
public struct AsyncTextFieldAlertInfo {
    let title: String
    let prompt: String
    let message: String
    let actionButtonText: String
    
    public init(title: String = "", prompt: String = "Enter name...", message: String = "Enter the name for your item", actionButtonText: String = "Save") {
        self.title = title
        self.prompt = prompt
        self.message = message
        self.actionButtonText = actionButtonText
    }
}
