//
//  DelayedOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct DelayedOnAppearViewModifier: ViewModifier {
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let seconds: Double
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    private func performAction() async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000)) // Convert seconds to nanoseconds
        context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                Task {
                    await performAction()
                }
            }
    }
}

public extension View {
    /// Executes an asynchronous action after a delay when the view appears.
    ///
    /// This modifier runs a provided async action after a specified delay
    /// once the view enters the screen. It’s useful for deferring initialization
    /// tasks, animations, or data loading that shouldn’t occur immediately on appearance.
    ///
    /// The async action is automatically wrapped with `NnErrorHandlingContext.performAction`,
    /// allowing for consistent error and loading state management across your app.
    ///
    /// - Parameters:
    ///   - seconds: The number of seconds to wait before performing the action.
    ///   - hideLoadingIndicator: A Boolean indicating whether the loading indicator should be hidden during execution. Defaults to `true`.
    ///   - action: The asynchronous action to execute after the delay.
    /// - Returns: A modified view that performs the async action after the specified delay when it appears.
    func delayedOnAppear(
        seconds: Double,
        hideLoadingIndicator: Bool = true,
        perform action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            DelayedOnAppearViewModifier(
                seconds: seconds,
                hideLoadingIndicator: hideLoadingIndicator,
                action: action
            )
        )
    }
}
