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

public extension View {
    func onlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
}
