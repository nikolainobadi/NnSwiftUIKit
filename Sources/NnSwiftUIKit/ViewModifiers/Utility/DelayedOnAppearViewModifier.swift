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
    
    /// Modifies the content view to perform an action after a delay when it appears.
    func body(content: Content) -> some View {
        content
            .onAppear {
                // Using Task to handle the delay and action
                Task {
                    try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000)) // Convert seconds to nanoseconds
                    action()
                }
            }
    }
}
