//
//  ConditionalNavigationLinkViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

@available(iOS 16.0, *)
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

@available(iOS 16.0, *)
public extension View {
    func asNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
    }
}