//
//  CustomSwipeActionViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import SwiftUI

/// A view modifier that adds a custom swipe action to a SwiftUI view with customizable appearance and behavior.
@available(iOS 15.0, *)
struct CustomSwipeActionViewModifier: ViewModifier {
    /// Information related to the swipe action's accessibility.
    let info: AccessibleItemInfo
    
    /// The system image to be used for the swipe action button.
    let systemImage: String?
    
    /// The edge on which the swipe action is applied (leading or trailing).
    let edge: HorizontalEdge
    
    /// The tint color for the swipe action button.
    let tint: Color
    
    /// A boolean value indicating whether the swipe action is active.
    let isActive: Bool
    
    /// The action to perform when the swipe action is triggered.
    let action: () -> Void
    
    /// Modifies the content view to add a custom swipe action with the specified settings.
    func body(content: Content) -> some View {
        if isActive {
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
                    .nnSetAccessibiltyId(info.accessibilityId)
                }
        } else {
            content
        }
    }
}
