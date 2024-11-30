//
//  ShowcasedViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

import SwiftUI

#if canImport(UIKit)
/// A view modifier that adds a showcase highlight effect to a SwiftUI view.
@available(iOS 16.4, *)
struct ShowcasedViewModifier: ViewModifier {
    /// The title associated with the highlighted view.
    let title: String
    
    /// The order number that determines the sequence of the showcase.
    let orderNumber: Int
    
    /// The corner radius of the highlighted area.
    let cornerRadius: CGFloat
    
    /// The style of the rounded corners.
    let style: RoundedCornerStyle
    
    /// The scale factor of the highlighted area.
    let scale: CGFloat
    
    /// Modifies the content view to add a showcase highlight effect.
    func body(content: Content) -> some View {
        content
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds, transform: { anchor in
                return [orderNumber: .init(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)]
            })
    }
}

@available(iOS 16.4, *)
public extension View {
    func showcased(_ title: String, order: Int, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
        modifier(ShowcasedViewModifier(title: title, orderNumber: order, cornerRadius: cornerRadius, style: style, scale: scale))
    }
}
#endif
