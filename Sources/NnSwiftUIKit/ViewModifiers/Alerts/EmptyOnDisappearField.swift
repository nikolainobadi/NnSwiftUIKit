//
//  EmptyOnDisappearField.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

/// A custom text field that clears its text when it disappears from the view hierarchy.
struct EmptyOnDisappearField: View {
    /// A binding for the text displayed in the text field.
    @Binding var text: String
    
    /// The placeholder text for the text field.
    let prompt: String
    
    /// Initializes an `EmptyOnDisappearField` with the specified prompt and text binding.
    /// - Parameters:
    ///   - prompt: The placeholder text for the field.
    ///   - text: A binding to the text in the field.
    init(_ prompt: String, text: Binding<String>) {
        self._text = text
        self.prompt = prompt
    }
    
    /// The body of the `EmptyOnDisappearField`, containing the text field and its behavior.
    var body: some View {
        TextField(prompt, text: $text)
            .autocorrectionDisabled()
            #if canImport(UIKit)
            .autocapitalization(.none)
            #endif
            .onDisappear {
                text = ""
            }
    }
}

