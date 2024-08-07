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
    let accessibilityId: String?
    
    init(_ prompt: String, text: Binding<String>, accessibilityId: String?) {
        self._text = text
        self.prompt = prompt
        self.accessibilityId = accessibilityId
    }
    
    var body: some View {
        TextField(prompt, text: $text)
            .nnSetAccessibiltyId(accessibilityId)
            .onDisappear {
                text = ""
            }
    }
}
