//
//  AlertCancelPromptKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/24.
//

import SwiftUI

struct AlertCancelInfoKey: EnvironmentKey {
    static let defaultValue = AccessibleItemInfo(prompt: "Okay")
}

public extension EnvironmentValues {
    var alertCancelInfo: AccessibleItemInfo {
        get { self[AlertCancelInfoKey.self] }
        set { self[AlertCancelInfoKey.self] = newValue }
    }
}

public extension View {
    /// Sets the default information for alert cancel buttons throughout the view hierarchy.
    ///
    /// This environment value is used by alert modifiers (like `showingAlert`)
    /// to display consistent cancel button configuration across your app. Individual modifiers can still
    /// override this value by passing an explicit `cancelInfo` parameter.
    ///
    /// - Parameter info: The accessibility information for alert cancel buttons. Defaults to `AccessibleItemInfo(prompt: "Okay")`.
    ///
    /// - Returns: A view with the alert cancel info set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .alertCancelInfo(.init(prompt: "Dismiss", accessibilityId: "dismissButton"))
    ///     .showingAlert("Title", message: "Message", isPresented: $isPresented)
    /// ```
    func alertCancelInfo(_ info: AccessibleItemInfo) -> some View {
        environment(\.alertCancelInfo, info)
    }

    /// Sets the default text for alert cancel buttons throughout the view hierarchy.
    ///
    /// This is a convenience method that creates an `AccessibleItemInfo` with just a prompt.
    /// For more control (including accessibility identifiers), use `alertCancelInfo(_:)` instead.
    ///
    /// - Parameter prompt: The text to display on alert cancel buttons.
    ///
    /// - Returns: A view with the alert cancel prompt set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .alertCancelPrompt("Dismiss")
    ///     .showingAlert("Title", message: "Message", isPresented: $isPresented)
    /// ```
    func alertCancelPrompt(_ prompt: String) -> some View {
        environment(\.alertCancelInfo, .init(prompt: prompt))
    }
}
