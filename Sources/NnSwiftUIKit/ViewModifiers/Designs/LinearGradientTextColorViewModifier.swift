//
//  LinearGradientTextColorViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

/// A view modifier that applies a linear gradient to the text color of a SwiftUI view.
struct LinearGradientTextColorViewModifier: ViewModifier {
    /// The linear gradient to be applied to the text color.
    let gradient: LinearGradient
    
    /// Modifies the content view to apply the linear gradient to the text color.
    func body(content: Content) -> some View {
        content
            .overlay(
                gradient.mask(content)
            )
    }
}

