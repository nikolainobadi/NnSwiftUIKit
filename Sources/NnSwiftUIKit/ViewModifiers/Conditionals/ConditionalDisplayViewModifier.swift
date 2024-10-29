//
//  ConditionalDisplayViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that conditionally displays a SwiftUI view based on a boolean value.
struct ConditionalDisplayViewModifier: ViewModifier {
    /// A boolean value indicating whether the content should be displayed.
    let conditional: Bool
    
    /// Modifies the content view to conditionally display it based on the `conditional` value.
    func body(content: Content) -> some View {
        if conditional {
            content
        }
    }
}

public extension View {
    /// Conditionally displays the view based on a boolean value.
    /// - Parameter conditional: A Boolean value indicating whether the view should be displayed.
    /// - Returns: The original view if `conditional` is true, or an empty view if false.
    func nnOnlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
}
