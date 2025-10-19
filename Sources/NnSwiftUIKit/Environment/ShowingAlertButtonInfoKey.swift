//
//  ShowingAlertButtonInfoKey.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/24.
//

import SwiftUI

struct ShowingAlertButtonInfoKey: EnvironmentKey {
    static let defaultValue = AccessibleItemInfo(prompt: "Okay")
}

public extension EnvironmentValues {
    var showingAlertButtonInfo: AccessibleItemInfo {
        get { self[ShowingAlertButtonInfoKey.self] }
        set { self[ShowingAlertButtonInfoKey.self] = newValue }
    }
}

public extension View {
    /// Sets the default information for showing alert buttons throughout the view hierarchy.
    ///
    /// This environment value is used by the `showingAlert` modifier
    /// to display consistent button configuration across your app. Individual modifiers can still
    /// override this value by passing an explicit `cancelInfo` parameter.
    ///
    /// - Parameter info: The accessibility information for showing alert buttons. Defaults to `AccessibleItemInfo(prompt: "Okay")`.
    ///
    /// - Returns: A view with the showing alert button info set in its environment.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .showingAlertButtonInfo(.init(prompt: "Dismiss", accessibilityId: "dismissButton"))
    ///     .showingAlert("Title", message: "Message", isPresented: $isPresented)
    /// ```
    func showingAlertButtonInfo(_ info: AccessibleItemInfo) -> some View {
        environment(\.showingAlertButtonInfo, info)
    }
}
