//
//  ConditionalDisplayViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct ConditionalDisplayViewModifier: ViewModifier {
    let conditional: Bool
    
    func body(content: Content) -> some View {
        if conditional {
            content
        }
    }
}

public extension View {
    /// Conditionally displays the view based on a boolean value.
    ///
    /// This modifier removes the view entirely from the hierarchy when `conditional` is false.
    /// Because SwiftUI reinitializes views when their modifier chain changes, using this approach
    /// on stateful views (those owning `@State`, `@ObservedObject`, or other sources of truth)
    /// can lead to unintended side effects such as losing local state or resetting bindings.
    ///
    /// It is recommended to use this modifier **only on stateless views** or those that
    /// **do not own their own source of truth**, to prevent unexpected reinitialization or
    /// view identity issues.
    ///
    /// - Parameter conditional: A Boolean value indicating whether the view should be displayed.
    /// - Returns: The original view if `conditional` is true, or an empty view if false.
    func onlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
}
