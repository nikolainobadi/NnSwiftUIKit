//
//  ConditionalBorderOverlayViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct ConditionalBorderOverlayViewModifier: ViewModifier {
    let color: Color
    let showOverlay: Bool
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color)
                    .onlyShow(when: showOverlay)
            )
    }
}

public extension View {
    /// Adds a border overlay with specified color and radius, conditionally based on a boolean value.
    /// - Parameters:
    ///   - showOverlay: A Boolean value indicating whether to show the overlay.
    ///   - color: The color of the border, defaulting to red.
    ///   - cornerRadius: The corner radius of the border, defaulting to 10.
    /// - Returns: A modified view with a conditional border overlay.
    func withBorderOverlay(_ showOverlay: Bool, color: Color? = nil, cornerRadius: CGFloat? = nil) -> some View {
        modifier(ConditionalBorderOverlayViewModifier(color: color ?? .red, showOverlay: showOverlay, cornerRadius: cornerRadius ?? 10))
    }
}
