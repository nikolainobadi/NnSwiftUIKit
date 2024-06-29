//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct ShowingAlertViewModifier: ViewModifier {
    @Binding var presented: Bool
    
    let title: String
    let message: String
    let buttonText: String
    let finished: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $presented) {
                Button(buttonText, role: .cancel) { finished?() }
            } message: {
                Text(message)
            }
    }
}
