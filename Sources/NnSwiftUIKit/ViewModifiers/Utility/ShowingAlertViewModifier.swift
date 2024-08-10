//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that displays an alert in a SwiftUI view with a custom message and button text.
@available(iOS 15.0, *)
struct ShowingAlertViewModifier: ViewModifier {
    /// A binding that controls whether the alert is presented.
    @Binding var presented: Bool
    
    /// The title of the alert.
    let title: String
    
    /// The message displayed in the alert.
    let message: String
    
    /// The text displayed on the alert button.
    let buttonText: String
    
    /// An optional closure that is executed when the alert is dismissed.
    let finished: (() -> Void)?
    
    /// Modifies the content view to display an alert with the specified title, message, and button text.
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $presented) {
                Button(buttonText, role: .cancel) {
                    finished?()
                }
            } message: {
                Text(message)
            }
    }
}
