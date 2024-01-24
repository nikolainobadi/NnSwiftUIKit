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
                    .nnOnlyShow(when: showOverlay)
            )
    }
}
