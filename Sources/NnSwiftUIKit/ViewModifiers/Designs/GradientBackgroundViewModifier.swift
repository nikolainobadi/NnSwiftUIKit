//
//  GradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct GradientBackgroundViewModifier: ViewModifier {
    let gradientType: NnGradientType
    let opacity: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(gradientType.linearGradient.ignoresSafeArea().opacity(opacity))
    }
}
