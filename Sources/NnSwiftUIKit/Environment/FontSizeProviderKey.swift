//
//  FontSizeProviderKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/25.
//

import SwiftUI

struct FontSizeProviderKey: EnvironmentKey {
    static let defaultValue: FontSizeProvider = DefaultFontSizeProvider()
}

public extension EnvironmentValues {
    var fontSizeProvider: FontSizeProvider {
        get { self[FontSizeProviderKey.self] }
        set { self[FontSizeProviderKey.self] = newValue }
    }
}

public extension View {
    /// Sets a custom font size provider for the view hierarchy.
    ///
    /// This allows you to customize how font sizes are calculated for different text styles.
    /// The default provider uses percentage-based calculations relative to screen height.
    ///
    /// - Parameter provider: A type conforming to `FontSizeProvider` that calculates font sizes.
    ///
    /// - Returns: A view with the custom font size provider set in its environment.
    ///
    /// Example:
    /// ```swift
    /// struct MyCustomProvider: FontSizeProvider {
    ///     func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat {
    ///         // Custom sizing logic
    ///         return 16
    ///     }
    /// }
    ///
    /// ContentView()
    ///     .fontSizeProvider(MyCustomProvider())
    /// ```
    func fontSizeProvider(_ provider: FontSizeProvider) -> some View {
        environment(\.fontSizeProvider, provider)
    }
}
