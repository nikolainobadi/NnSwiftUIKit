//
//  ConditionalNavigationLinkViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that conditionally adds a navigation link to a SwiftUI view for iOS 16+.
struct ConditionalNavigationLinkViewModifier<D: Hashable>: ViewModifier {
    /// The data used for the navigation link.
    let data: D
    
    /// A boolean value indicating whether the navigation link is active.
    let isActive: Bool
    
    /// Modifies the content view to conditionally add a navigation link based on the `isActive` value.
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
    func nnAsNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
    }
}
