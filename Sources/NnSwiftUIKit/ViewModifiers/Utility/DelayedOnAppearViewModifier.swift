//
//  DelayedOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that performs a delayed action after the view appears in a SwiftUI view.
struct DelayedOnAppearViewModifier: ViewModifier {
    @EnvironmentObject var context: NnErrorHandlingContext
    
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
    func delayedOnAppear(seconds: Double, hideLoadingIndicator: Bool = true, perform action: @escaping () async throws -> Void) -> some View {
        modifier(DelayedOnAppearViewModifier(seconds: seconds, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
