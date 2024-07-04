//
//  CustomAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomAlertViewModifier<AlertView: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let message: String
    let buttonText: String
    let cancelText: String
    let action: () async throws -> Void
    let cancelAction: () -> Void
    let alertView: () -> AlertView

    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented) {
                alertView()
                NnAsyncTryButton(buttonText, role: .destructive, action: action)
                
                Button(cancelText, action: cancelAction)
            }
    }
}
