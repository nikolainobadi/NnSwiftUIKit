//
//  RowItemTintKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/24.
//

import SwiftUI

struct RowItemTintKey: EnvironmentKey {
    static let defaultValue: Color = .primary
}

public extension EnvironmentValues {
    var rowItemTint: Color {
        get { self[RowItemTintKey.self] }
        set { self[RowItemTintKey.self] = newValue }
    }
}

public extension View {
    /// Sets the default tint color for row item chevrons throughout the view hierarchy.
    ///
    /// This environment value is used by the `asRowItem` modifier
    /// to apply consistent chevron coloring across your app. Individual modifiers can still
    /// override this value by passing an explicit `tint` parameter.
    ///
    /// - Parameter tint: The color for row item chevrons. Defaults to `.primary`.
    ///
    /// - Returns: A view with the row item tint set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .rowItemTint(.blue)
    ///     .asRowItem(withChevron: true)
    /// ```
    func rowItemTint(_ tint: Color) -> some View {
        environment(\.rowItemTint, tint)
    }
}
