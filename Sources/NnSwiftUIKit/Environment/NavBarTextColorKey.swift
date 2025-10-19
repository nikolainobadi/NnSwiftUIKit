//
//  NavBarTextColorKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/24.
//

import SwiftUI

struct NavBarTextColorKey: EnvironmentKey {
    static let defaultValue: Color = .primary
}

public extension EnvironmentValues {
    var navBarTextColor: Color {
        get { self[NavBarTextColorKey.self] }
        set { self[NavBarTextColorKey.self] = newValue }
    }
}

public extension View {
    /// Sets the default text color for navigation bar buttons throughout the view hierarchy.
    ///
    /// This environment value is used by navigation bar button modifiers
    /// (`withNavBarButton`, `withNavBarDismissButton`, `activeOnChangeNavBarButton`, `withDiscardChangesNavBarDismissButton`)
    /// to apply consistent text coloring across your app. Individual modifiers can still
    /// override this value by passing an explicit `textColor` or `buttonTextColor` parameter.
    ///
    /// - Parameter color: The color for navigation bar button text. Defaults to `.primary`.
    ///
    /// - Returns: A view with the nav bar text color set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .navBarTextColor(.white)
    ///     .withNavBarButton(buttonContent: .text("Save"), action: saveAction)
    /// ```
    func navBarTextColor(_ color: Color) -> some View {
        environment(\.navBarTextColor, color)
    }
}
