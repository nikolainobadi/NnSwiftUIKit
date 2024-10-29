//
//  ConditionalViewReplacementViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 10/29/24.
//

import SwiftUI

struct ConditionalViewReplacementViewModifier<Conditional: View>: ViewModifier {
    let isShowing: Bool
    let conditionalView: () -> Conditional
    
    func body(content: Content) -> some View {
        if isShowing {
            conditionalView()
        } else {
            content
        }
    }
}

public extension View {
    func nnShowingConditionalView<V: View>(isShowing: Bool, @ViewBuilder conditionalView: @escaping () -> V) -> some View {
        modifier(ConditionalViewReplacementViewModifier(isShowing: isShowing, conditionalView: conditionalView))
    }
}
