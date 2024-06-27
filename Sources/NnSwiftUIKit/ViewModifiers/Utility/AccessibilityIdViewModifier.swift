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
