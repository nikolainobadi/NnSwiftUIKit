//
//  AsyncTryTapGestureViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/10/26.
//

import SwiftUI

struct AsyncTryTapGestureViewModifier: ViewModifier {
    @EnvironmentObject private var context: NnErrorHandlingContext

    let count: Int
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void

    func body(content: Content) -> some View {
        content
            .onTapGesture(count: count) {
                context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
            }
    }
}

public extension View {
    /// Adds an asynchronous, error-handled tap gesture to the view.
    ///
    /// Use this when an entire row or non-Button view needs to invoke an async throwing
    /// action that should surface errors through the shared `NnErrorHandlingContext`
    /// rather than being silently ignored. Particularly useful for rows that contain
    /// nested `Button`/`AsyncTryButton` controls (where wrapping the row in another
    /// button would be illegal).
    ///
    /// Requires an `NnErrorHandlingContext` in the environment — typically provided
    /// via `.withNnErrorHandling()` at a parent view.
    ///
    /// - Parameters:
    ///   - count: The number of taps required to trigger the action. Defaults to `1`.
    ///   - hideLoadingIndicator: When `true`, the shared loading spinner is suppressed for this action. Defaults to `false`.
    ///   - action: The asynchronous throwing action to perform on tap.
    /// - Returns: A view that performs the async action on tap and routes errors through the error context.
    func asyncTapGesture(
        count: Int = 1,
        hideLoadingIndicator: Bool = false,
        action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            AsyncTryTapGestureViewModifier(
                count: count,
                hideLoadingIndicator: hideLoadingIndicator,
                action: action
            )
        )
    }
}
