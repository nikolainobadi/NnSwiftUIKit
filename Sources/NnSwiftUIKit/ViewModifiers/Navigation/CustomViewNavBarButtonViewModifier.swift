//
//  CustomViewNavBarButtonViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/9/26.
//

#if os(iOS)
import SwiftUI

struct CustomViewNavBarButtonViewModifier<V: View>: ViewModifier {
    @ViewBuilder let customView: () -> V

    let placement: ToolbarItemPlacement
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    if isActive {
                        customView()
                    }
                }
            }
    }
}

public extension View {
    /// Adds a custom view as a navigation bar button using the toolbar modifier.
    ///
    /// - Parameters:
    ///   - placement: The placement of the toolbar item. Defaults to `.topBarTrailing`.
    ///   - isActive: Whether the custom view should be displayed. Defaults to `true`.
    ///   - customView: A view builder closure that returns the custom view to display as a toolbar item.
    /// - Returns: A view with the custom navigation bar button added to the toolbar.
    func withCustomNavBarButton<V: View>(placement: ToolbarItemPlacement = .topBarTrailing, isActive: Bool = true, @ViewBuilder customView: @escaping () -> V) -> some View {
        modifier(CustomViewNavBarButtonViewModifier(customView: customView, placement: placement, isActive: isActive))
    }
}
#endif
