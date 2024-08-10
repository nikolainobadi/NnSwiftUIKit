//
//  ConditionalBorderOverlayViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that adds a border overlay to a SwiftUI view, conditionally based on a boolean value.
struct ConditionalBorderOverlayViewModifier: ViewModifier {
    /// The color of the border.
    let color: Color
    
    /// A boolean value indicating whether the overlay should be shown.
    let showOverlay: Bool
    
    /// The corner radius of the border.
    let cornerRadius: CGFloat
    
    /// Modifies the content view to conditionally add a border overlay.
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color)
                    .nnOnlyShow(when: showOverlay)
            )
    }
}
