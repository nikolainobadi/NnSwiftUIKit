//
//  GradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct GradientBackgroundViewModifier: ViewModifier {
    let opacity: CGFloat
    let gradient: LinearGradient
    
    func body(content: Content) -> some View {
        content
            .background(gradient.ignoresSafeArea().opacity(opacity))
    }
}

public extension View {
    /// Applies a linear gradient background with specified opacity to the view.
    /// - Parameters:
    ///   - gradient: The linear gradient to use as the background.
    ///   - opacity: The opacity level for the gradient, defaulting to 1.
    /// - Returns: A modified view with a gradient background.
    func linearGradientBackground(_ gradient: LinearGradient, opacity: CGFloat? = nil) -> some View {
        modifier(GradientBackgroundViewModifier(opacity: opacity ?? 1, gradient: gradient))
    }
}
