//
//  GradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct GradientBackgroundViewModifier: ViewModifier {
    let gradient: LinearGradient
    let opacity: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(gradient.ignoresSafeArea().opacity(opacity))
    }
}
