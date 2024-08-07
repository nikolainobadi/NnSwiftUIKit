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
    let firstFieldInfo: AccessibleItem
    let secondFieldInfo: AccessibleItem
    let buttonInfo: AccessibleItem?
    let cancelInfo: AccessibleItem?
    let action: (String, String) async throws -> Void
    
    private func save() async throws {
        try await action(firstFieldText, secondFieldText)
    }
    
    func body(content: Content) -> some View {
        content
            .nnAsyncAlert(message, isPresented: $isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: save) {
                EmptyOnDisappearField(firstFieldInfo.prompt, text: $firstFieldText)
                    .nnSetAccessibiltyId(firstFieldInfo.accessibilityId)
                EmptyOnDisappearField(secondFieldInfo.prompt, text: $secondFieldText)
                    .nnSetAccessibiltyId(secondFieldInfo.accessibilityId)
            }
    }
}

