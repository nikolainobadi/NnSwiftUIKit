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
    /// Replaces the view with a specified view conditionally based on a boolean value.
    /// - Parameters:
    ///   - isShowing: A Boolean value indicating whether to show the replacement view.
    ///   - conditionalView: A closure returning the replacement view.
    /// - Returns: A modified view that shows the replacement view when `isShowing` is true.
    func showingConditionalView<V: View>(when isShowing: Bool, @ViewBuilder conditionalView: @escaping () -> V) -> some View {
        modifier(ConditionalViewReplacementViewModifier(isShowing: isShowing, conditionalView: conditionalView))
    }
}
