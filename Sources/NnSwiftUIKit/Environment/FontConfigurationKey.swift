//
//  FontConfigurationKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/25.
//

import SwiftUI

struct FontConfigurationKey: EnvironmentKey {
    static let defaultValue: FontConfiguration = .init()
}

public extension EnvironmentValues {
    var fontConfiguration: FontConfiguration {
        get { self[FontConfigurationKey.self] }
        set { self[FontConfigurationKey.self] = newValue }
    }
}

public extension View {
    /// Sets the default font configuration for the view hierarchy.
    ///
    /// This allows you to configure default values for text color and font names
    /// that will be used by font modifiers (`withFont`, `setCustomFont`) unless
    /// explicitly overridden on a per-use basis.
    ///
    /// - Parameter configuration: The font configuration to apply as defaults.
    ///
    /// - Returns: A view with the font configuration set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .fontConfiguration(FontConfiguration(
    ///         textColor: .blue,
    ///         detailFontName: "CustomDetail",
    ///         nonDetailFontName: "CustomBold"
    ///     ))
    /// ```
    func fontConfiguration(_ configuration: FontConfiguration) -> some View {
        environment(\.fontConfiguration, configuration)
    }
}
