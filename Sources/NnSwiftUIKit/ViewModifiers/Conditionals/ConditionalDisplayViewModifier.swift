//
//  ConditionalDisplayViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct ConditionalDisplayViewModifier: ViewModifier {
    let conditional: Bool

    func body(content: Content) -> some View {
        if conditional {
            content
        }
    }
}
