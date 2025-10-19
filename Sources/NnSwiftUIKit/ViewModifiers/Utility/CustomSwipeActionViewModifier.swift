//
//  CustomSwipeActionViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import SwiftUI

struct CustomSwipeActionViewModifier: ViewModifier {
    let info: AccessibleItemInfo
    let systemImage: String?
    let edge: HorizontalEdge
    let tint: Color
    let isActive: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .swipeActions(edge: edge) {
                    AsyncTryButton(action: action) {
                        if let systemImage = systemImage {
                            Label(info.prompt, systemImage: systemImage)
                        } else {
                            Text(info.prompt)
                        }
                    }
                    .tint(tint)
                    .setOptionalAccessibiltyId(info.accessibilityId)
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Adds a custom asynchronous swipe action to the view with configurable appearance and behavior.
    ///
    /// This modifier conditionally attaches a `.swipeActions` modifier based on `isActive`.
    /// Because SwiftUI rebuilds views when modifier chains differ, toggling `isActive`
    /// can lead to view reinitialization, state resets, or unexpected behavior in child views
    /// that manage their own state or bindings.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**. For stateful views,
    /// prefer always keeping a `.swipeActions` modifier applied and controlling
    /// its visibility or enabled state within the action content itself.
    ///
    /// The swipe action uses an `AsyncTryButton` to perform async operations safely,
    /// handling thrown errors and integrating accessibility identifiers from `AccessibleItemInfo`.
    ///
    /// - Parameters:
    ///   - info: Accessibility and prompt information for the swipe action.
    ///   - systemImage: An optional system image name to display alongside the label.
    ///   - tint: The color used to tint the swipe action button.
    ///   - edge: The edge on which the swipe action appears. Defaults to `.trailing`.
    ///   - isActive: A Boolean controlling whether the swipe action is applied. Defaults to `true`.
    ///   - action: The asynchronous action executed when the swipe action button is tapped.
    /// - Returns: A modified view with an async-enabled swipe action when active.
    func withSwipeAction(
        info: AccessibleItemInfo,
        systemImage: String? = nil,
        tint: Color,
        edge: HorizontalEdge? = nil,
        isActive: Bool = true,
        action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            CustomSwipeActionViewModifier(
                info: info,
                systemImage: systemImage,
                edge: edge ?? .trailing,
                tint: tint,
                isActive: isActive,
                action: action
            )
        )
    }
}
