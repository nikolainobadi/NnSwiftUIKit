//
//  AccessibilityIdViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/27/24.
//

import SwiftUI

/// A view modifier that sets an accessibility identifier for a SwiftUI view.
struct AccessibilityIdViewModifier: ViewModifier {
    /// The accessibility identifier to be set on the view.
    let accessibilityId: String?
    
    /// Modifies the content view to set the accessibility identifier.
    func body(content: Content) -> some View {
        if let accessibilityId = accessibilityId {
            content
                .accessibilityIdentifier(accessibilityId)
        } else {
            content
        }
    }
}

public extension View {
    /// Sets an accessibility identifier for the view.
    /// - Parameter id: The accessibility identifier to set.
    /// - Returns: A modified view with the specified accessibility identifier.
    func nnSetAccessibiltyId(_ id: String?) -> some View {
        modifier(AccessibilityIdViewModifier(accessibilityId: id))
    }
}
