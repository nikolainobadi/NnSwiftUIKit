//
//  DisableButtonViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/9/26.
//

import SwiftUI

struct DisableButtonViewModifier: ViewModifier {
    let isDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.5 : 1)
    }
}

public extension View {
    /// Disables the button and reduces its opacity when disabled.
    ///
    /// - Parameter isDisabled: Whether the button should be disabled. When `true`, the button is disabled and its opacity is set to 0.5.
    /// - Returns: A view with disabled state and adjusted opacity.
    func disableButton(_ isDisabled: Bool) -> some View {
        modifier(DisableButtonViewModifier(isDisabled: isDisabled))
    }
}
