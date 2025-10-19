//
//  ConditionalNavigationLinkViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct ConditionalNavigationLinkViewModifier<D: Hashable>: ViewModifier {
    let data: D
    let isActive: Bool
    
    func body(content: Content) -> some View {
        if isActive {
            NavigationLink(value: data) {
                content
            }
        } else {
            content
        }
    }
}

public extension View {
    /// Conditionally wraps the view in a `NavigationLink` when `isActive` is true.
    ///
    /// This modifier dynamically changes the view hierarchy based on the `isActive` value.
    /// Because SwiftUI reconstructs views when their modifier chain changes, applying this
    /// to views that manage state (e.g., views with `@State`, `@ObservedObject`, or bindings)
    /// can cause those views to lose their state or reset unexpectedly when the condition toggles.
    ///
    /// It is best to use this modifier **only on stateless or display-only views** that do not
    /// maintain their own source of truth. For stateful navigation scenarios, prefer maintaining
    /// a stable `NavigationLink` and controlling its activation through a binding.
    ///
    /// - Parameters:
    ///   - data: The data used to identify the navigation destination.
    ///   - isActive: A Boolean indicating whether the navigation link should be active. Defaults to `true`.
    /// - Returns: A modified view that becomes a `NavigationLink` when `isActive` is true.
    func asNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
    }
}
