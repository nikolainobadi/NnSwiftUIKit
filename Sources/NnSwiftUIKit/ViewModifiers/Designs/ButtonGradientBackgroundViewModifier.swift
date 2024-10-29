//
//  ButtonGradientBackgroundViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a rounded button with a linear gradient background, corner radius, shadow color, and shadow radius.
struct ButtonGradientBackgroundViewModifier: ViewModifier {
    /// The linear gradient to be applied as the button background.
    let gradient: LinearGradient
    
    /// The corner radius for the button.
    let cornerRadius: CGFloat
    
    /// The color of the button's shadow.
    let shadowColor: Color
    
    /// The radius of the button's shadow.
    let shadowRadius: CGFloat
    
    /// Modifies the content view to configure it as a rounded button with a gradient background and shadow.
    func body(content: Content) -> some View {
        content
            .nnLinearGradientBackground(gradient)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}

public extension View {
    func nnRoundedButtonLinearGradientBackround(_ gradient: LinearGradient, cornerRadius: CGFloat = 10, shadowColor: Color = .primary, shadowRadius: CGFloat = 4) -> some View {
        modifier(ButtonGradientBackgroundViewModifier(gradient: gradient, cornerRadius: cornerRadius, shadowColor: shadowColor, shadowRadius: shadowRadius))
    }
}
