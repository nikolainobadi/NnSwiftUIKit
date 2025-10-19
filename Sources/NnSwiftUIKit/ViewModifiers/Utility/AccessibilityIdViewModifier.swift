//
//  AccessibilityIdViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/27/24.
//

import SwiftUI

struct AccessibilityIdViewModifier: ViewModifier {
    let accessibilityId: String?
    
    func body(content: Content) -> some View {
        if let accessibilityId {
            content
                .accessibilityIdentifier(accessibilityId)
        } else {
            content
        }
    }
}

public extension View {
    /// Conditionally applies an accessibility identifier when an ID is provided.
    ///
    /// This modifier changes the view hierarchy when the identifier’s presence toggles.
    /// Because SwiftUI reconstructs views when modifier chains differ, switching between
    /// `nil` and non-`nil` identifiers can cause reinitialization and potential state loss
    /// for views that own internal state or bindings.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**. For stateful views, prefer
    /// always applying a stable `.accessibilityIdentifier("")` and updating its value
    /// reactively rather than conditionally.
    ///
    /// - Parameter id: The optional accessibility identifier to assign to the view.
    /// - Returns: A modified view with the given accessibility identifier when non-nil.
    func setOptionalAccessibiltyId(_ id: String?) -> some View {
        modifier(AccessibilityIdViewModifier(accessibilityId: id))
    }
}
