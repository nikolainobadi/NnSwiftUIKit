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
    /// Conditionally replaces the current view with another view when `isShowing` is true.
    ///
    /// This modifier changes the view hierarchy depending on the boolean value provided.
    /// Because SwiftUI reconstructs views when their modifier chain differs, toggling
    /// between `true` and `false` can cause stateful views to lose local state,
    /// reset animations, or reinitialize bindings and environment values.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not own their own source of truth**. For views with internal state,
    /// prefer keeping a consistent view hierarchy and conditionally changing
    /// internal content or opacity instead of replacing the view entirely.
    ///
    /// - Parameters:
    ///   - isShowing: A Boolean value indicating whether to display the replacement view.
    ///   - conditionalView: A closure that returns the replacement view when `isShowing` is true.
    /// - Returns: A modified view that displays the replacement view when `isShowing` is true,
    ///   or the original view otherwise.
    func showingConditionalView<V: View>(when isShowing: Bool, @ViewBuilder conditionalView: @escaping () -> V) -> some View {
        modifier(ConditionalViewReplacementViewModifier(isShowing: isShowing, conditionalView: conditionalView))
    }
}
