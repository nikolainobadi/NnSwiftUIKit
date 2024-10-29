//
//  GradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that applies a linear gradient background to a SwiftUI view with customizable opacity.
struct GradientBackgroundViewModifier: ViewModifier {
    /// The linear gradient to be applied as the background.
    let gradient: LinearGradient
    
    /// The opacity level of the background.
    let opacity: CGFloat
    
    /// Modifies the content view to apply the linear gradient background with the specified opacity.
    func body(content: Content) -> some View {
        content
            .background(gradient.ignoresSafeArea().opacity(opacity))
    }
}

public extension View {
    func nnLinearGradientBackground(_ gradient: LinearGradient, opacity: CGFloat = 1) -> some View {
        modifier(GradientBackgroundViewModifier(gradient: gradient, opacity: opacity))
    }
}
