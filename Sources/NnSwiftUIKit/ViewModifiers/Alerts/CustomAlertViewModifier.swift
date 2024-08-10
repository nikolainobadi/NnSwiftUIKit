//
//  CustomAlertViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A view modifier that displays a custom asynchronous alert in a SwiftUI view.
@available(iOS 15.0, *)
struct CustomAlertViewModifier<AlertView: View>: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var isPresented: Bool
    
    /// The message displayed in the alert.
    let message: String
    
    /// Information related to the alert's action button.
    let buttonInfo: AccessibleItemInfo
    
    /// Information related to the alert's cancel button.
    let cancelInfo: AccessibleItemInfo
    
    /// The asynchronous action to perform when the action button is tapped.
    let action: () async throws -> Void
    
    /// The action to perform when the cancel button is tapped.
    let cancelAction: () -> Void
    
    /// The custom view content to be displayed within the alert.
    let alertView: () -> AlertView
    
    /// Modifies the content view to display a custom asynchronous alert.
    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented) {
                alertView()
                NnAsyncTryButton(buttonInfo.prompt, role: .destructive, action: action)
                    .nnSetAccessibiltyId(buttonInfo.accessibilityId)
                
                Button(cancelInfo.prompt, role: .cancel, action: cancelAction)
                    .nnSetAccessibiltyId(cancelInfo.accessibilityId)
            }
    }
}
