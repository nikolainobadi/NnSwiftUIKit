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
    func nnShowingViewWithOptional<I, V: View>(_ optional: I?, @ViewBuilder conditionalView: @escaping (I) -> V) -> some View {
        modifier(ConditionalOptionalViewModifier(optional: optional, conditionalView: conditionalView))
    }
}
