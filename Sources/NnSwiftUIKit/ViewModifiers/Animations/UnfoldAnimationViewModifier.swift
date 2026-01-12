//
//  UnfoldAnimationViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/20/25.
//

import SwiftUI

struct UnfoldAnimationViewModifier: ViewModifier {
    let isExpanded: Bool
    let behavior: UnfoldLayoutBehavior
    let animation: Animation

    func body(content: Content) -> some View {
        Group {
            switch behavior {
            case .occupiesSpace:
                content
                    .mask(
                        Rectangle()
                            .scaleEffect(y: isExpanded ? 1 : 0, anchor: .top)
                    )
                    .opacity(isExpanded ? 1 : 0)

            case .removesSpace:
                content
                    .frame(maxHeight: isExpanded ? .infinity : 0, alignment: .top)
                    .opacity(isExpanded ? 1 : 0)
                    .clipped()
            }
        }
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
    ///   - behavior: The layout behavior of the unfolding view. Defaults to `.removesSpace`.
    ///   - animation: The animation to use when the expansion state changes. Defaults to `.easeInOut`.
    ///
    /// - Returns: A view that unfolds or collapses based on the provided parameters.
    func unfold(
        when isExpanded: Bool,
        behavior: UnfoldLayoutBehavior = .removesSpace,
        animation: Animation = .easeInOut
    ) -> some View {
        modifier(
            UnfoldAnimationViewModifier(
                isExpanded: isExpanded,
                behavior: behavior,
                animation: animation
            )
        )
    }
}


// MARK: - Dependencies
public enum UnfoldLayoutBehavior {
    case occupiesSpace
    case removesSpace
}
