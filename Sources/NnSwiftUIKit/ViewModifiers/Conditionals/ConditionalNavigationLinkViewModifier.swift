//
//  ConditionalNavigationLinkViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that conditionally adds a navigation link to a SwiftUI view for iOS 16+.
struct ConditionalNavigationLinkViewModifier<D: Hashable>: ViewModifier {
    let data: D
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .showingConditionalView(when: isActive) {
                NavigationLink(value: data) {
                    content
                }
            }
    }
}

public extension View {
    /// Conditionally adds a navigation link to the view for navigation, available in iOS 16+.
    /// - Parameters:
    ///   - data: The data used for the navigation destination.
    ///   - isActive: A Boolean value indicating whether the navigation link is active, defaulting to true.
    /// - Returns: A modified view that displays a navigation link when `isActive` is true.
    func asNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
    }
}
