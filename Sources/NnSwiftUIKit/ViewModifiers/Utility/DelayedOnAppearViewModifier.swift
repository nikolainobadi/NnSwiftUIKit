//
//  DelayedOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that performs a delayed action after the view appears in a SwiftUI view.
struct DelayedOnAppearViewModifier: ViewModifier {
    /// The delay before the action is performed, in seconds.
    let seconds: Double
    
    /// The action to perform after the delay.
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                Task {
                    try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000)) // Convert seconds to nanoseconds
                    action()
                }
            }
    }
}
public extension View {
    /// Performs an action after a specified delay when the view appears.
    /// - Parameters:
    ///   - seconds: The delay in seconds before performing the action.
    ///   - action: The action to perform after the delay.
    /// - Returns: A modified view that performs an action after a delay upon appearing.
    func nnDelayedOnAppear(seconds: Double, perform action: @escaping () -> Void) -> some View {
        modifier(DelayedOnAppearViewModifier(seconds: seconds, action: action))
    }
}
