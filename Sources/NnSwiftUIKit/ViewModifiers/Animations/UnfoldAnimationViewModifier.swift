//
//  UnfoldAnimationViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/20/25.
//

import SwiftUI

struct UnfoldAnimationViewModifier: ViewModifier {
    let isExpanded: Bool
    let anchor: UnitPoint
    let animation: Animation
    
    func body(content: Content) -> some View {
        content
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(y: isExpanded ? 1 : 0, anchor: anchor)
            .clipped()
            .animation(animation, value: isExpanded)
    }
}

public extension View {
    /// Applies an unfolding and collapsing animation to the view based on a Boolean condition.
    ///
    /// This modifier animates the view's vertical scale and opacity to create an "unfolding" effect when expanding,
    /// and a collapsing effect when contracting. It is useful for progressively revealing or hiding content without abrupt transitions.
    ///
    /// - Parameters:
    ///   - isExpanded: A Boolean value that determines whether the view is expanded (`true`) or collapsed (`false`).
    ///   - anchor: The point from which the view unfolds or collapses. Defaults to `.top`.
    ///   - animation: The animation to use when the expansion state changes. Defaults to `.easeInOut`.
    ///
    /// - Returns: A view that unfolds or collapses based on the provided parameters.
    func unfold(when isExpanded: Bool, anchor: UnitPoint = .top, animation: Animation = .easeInOut) -> some View {
        modifier(UnfoldAnimationViewModifier(isExpanded: isExpanded, anchor: anchor, animation: animation))
    }
}
