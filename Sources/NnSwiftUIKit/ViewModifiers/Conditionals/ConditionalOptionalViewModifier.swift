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
    /// Conditionally replaces the view with another view if an optional item is provided.
    /// - Parameters:
    ///   - optional: The optional item to check for replacement.
    ///   - conditionalView: A closure returning the view to display if the item is present.
    /// - Returns: A modified view that displays a conditional view when the item is non-nil.
    func nnShowingViewWithOptional<I, V: View>(_ optional: I?, @ViewBuilder conditionalView: @escaping (I) -> V) -> some View {
        modifier(ConditionalOptionalViewModifier(optional: optional, conditionalView: conditionalView))
    }
}
