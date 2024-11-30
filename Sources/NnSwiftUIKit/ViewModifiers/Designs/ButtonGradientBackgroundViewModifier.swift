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
            .linearGradientBackground(gradient)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}

public extension View {
    /// Configures the view as a rounded button with a gradient background and shadow.
    /// - Parameters:
    ///   - gradient: The linear gradient to use as the button background.
    ///   - cornerRadius: The corner radius of the button, defaulting to 10.
    ///   - shadowColor: The color of the shadow, defaulting to primary.
    ///   - shadowRadius: The radius of the shadow, defaulting to 4.
    /// - Returns: A modified view styled as a rounded button with gradient and shadow.
    func roundedButtonLinearGradientBackround(_ gradient: LinearGradient, cornerRadius: CGFloat? = nil, shadowColor: Color? = nil, shadowRadius: CGFloat? = nil) -> some View {
        modifier(ButtonGradientBackgroundViewModifier(gradient: gradient, cornerRadius: cornerRadius ?? 10, shadowColor: shadowColor ?? .primary, shadowRadius: shadowRadius ?? 4))
    }
}
