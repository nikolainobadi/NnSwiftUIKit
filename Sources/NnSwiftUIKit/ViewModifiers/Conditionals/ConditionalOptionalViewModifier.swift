//
//  ConditionalOptionalViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 10/29/24.
//

import SwiftUI

struct ConditionalOptionalViewModifier<Item, ConditionalView: View>: ViewModifier {
    let optional: Item?
    let conditionalView: (Item) -> ConditionalView
    
    func body(content: Content) -> some View {
        if let optional {
            conditionalView(optional)
        } else {
            content
        }
    }
}

public extension View {
    /// Conditionally replaces the current view with another view when an optional value is non-nil.
    ///
    /// This modifier alters the view hierarchy depending on whether the optional contains a value.
    /// Because SwiftUI rebuilds views when modifier chains differ, toggling between `nil` and
    /// non-`nil` can lead to state loss or unintended resets in any child view that manages its own state.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views** that
    /// **do not own their own source of truth**. For stateful content, prefer always keeping
    /// a consistent hierarchy and conditionally updating content inside the same view instead.
    ///
    /// - Parameters:
    ///   - optional: The optional value to check for conditional replacement.
    ///   - conditionalView: A closure that returns the replacement view when the optional has a value.
    /// - Returns: A modified view that displays `conditionalView` when `optional` is non-nil, or the original view otherwise.
    func showingViewWithOptional<I, V: View>(_ optional: I?, @ViewBuilder conditionalView: @escaping (I) -> V) -> some View {
        modifier(ConditionalOptionalViewModifier(optional: optional, conditionalView: conditionalView))
    }
}
