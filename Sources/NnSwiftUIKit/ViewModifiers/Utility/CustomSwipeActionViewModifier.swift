//
//  CustomSwipeActionViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import SwiftUI

/// A view modifier that adds a custom swipe action to a SwiftUI view with customizable appearance and behavior.
struct CustomSwipeActionViewModifier: ViewModifier {
    let info: AccessibleItemInfo
    let systemImage: String?
    let edge: HorizontalEdge
    let tint: Color
    let isActive: Bool
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .showingConditionalView(when: isActive) {
                content
                    .swipeActions(edge: edge) {
                        Button(action: action) {
                            if let systemImage = systemImage {
                                Label(info.prompt, systemImage: systemImage)
                            } else {
                                Text(info.prompt)
                            }
                        }
                        .tint(tint)
                        .setOptionalAccessibiltyId(info.accessibilityId)
                    }
            }
    }
}

public extension View {
    /// Adds a custom swipe action to the view with configurable appearance and behavior.
    /// - Parameters:
    ///   - info: Accessibility information for the swipe action.
    ///   - systemImage: The system image to use for the swipe action button.
    ///   - tint: The tint color for the swipe action button.
    ///   - edge: The edge on which the swipe action is applied, defaulting to trailing.
    ///   - isActive: A Boolean indicating whether the swipe action is active.
    ///   - action: The action to perform when the swipe action is triggered.
    /// - Returns: A modified view with the specified swipe action.
    func withSwipeAction(info: AccessibleItemInfo, systemImage: String? = nil, tint: Color, edge: HorizontalEdge? = nil, isActive: Bool = true, action: @escaping () -> Void) -> some View {
        modifier(CustomSwipeActionViewModifier(info: info, systemImage: systemImage, edge: edge ?? .trailing, tint: tint, isActive: isActive, action: action))
    }
}
