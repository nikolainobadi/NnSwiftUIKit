//
//  ButtonGradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct ButtonGradientBackgroundViewModifier: ViewModifier {
    let gradientType: NnGradientType
    let cornerRadius: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .nnLinearGradientBackground(gradientType)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}
