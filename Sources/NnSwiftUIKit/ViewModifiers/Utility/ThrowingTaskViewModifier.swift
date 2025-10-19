//
//  ThrowingTaskViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/11/25.
//

import SwiftUI

struct ThrowingTaskViewModifier: ViewModifier {
    @State private var didPerformTask = false
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let onlyPerformOnce: Bool
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .task {
                if onlyPerformOnce, didPerformTask {
                    return
                }
                
                context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
                
                if onlyPerformOnce {
                    didPerformTask = true
                }
            }
    }
}

public extension View {
    /// Runs an asynchronous throwing task when the view appears, with optional single execution and error handling.
    ///
    /// This modifier attaches a SwiftUI `.task` that executes an async action when the view enters
    /// the task context. The task integrates with `NnErrorHandlingContext` to automatically handle
    /// loading and error states, ensuring consistent presentation across your app.
    ///
    /// You can configure it to run the task only once (even if the view reappears)
    /// or to re-run every time the view becomes active.
    ///
    /// - Parameters:
    ///   - hideLoadingIndicator: A Boolean indicating whether the loading indicator should be hidden during execution. Defaults to `true`.
    ///   - onlyPerformOnce: A Boolean that determines whether the task should only run once. Defaults to `false`.
    ///   - action: The asynchronous throwing task to perform.
    /// - Returns: A modified view that runs the specified async task with built-in error handling when it appears.
    func throwingTask(
        hideLoadingIndicator: Bool = true,
        onlyPerformOnce: Bool = false,
        perform action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            ThrowingTaskViewModifier(
                onlyPerformOnce: onlyPerformOnce,
                hideLoadingIndicator: hideLoadingIndicator,
                action: action
            )
        )
    }
}
