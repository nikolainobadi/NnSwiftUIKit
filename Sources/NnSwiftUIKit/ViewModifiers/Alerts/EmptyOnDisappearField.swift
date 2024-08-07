//
//  EmptyOnDisappearField.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

struct EmptyOnDisappearField: View {
    @Binding var text: String
    
    let prompt: String
    
    init(_ prompt: String, text: Binding<String>) {
        self._text = text
        self.prompt = prompt
    }
    
    var body: some View {
        TextField(prompt, text: $text)
            .onDisappear {
                text = ""
            }
    }
}
