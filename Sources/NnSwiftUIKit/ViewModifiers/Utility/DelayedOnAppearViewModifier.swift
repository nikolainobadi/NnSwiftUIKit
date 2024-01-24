//
//  DelayedOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct DelayedOnAppearViewModifier: ViewModifier {
    let seconds: Double
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear { // using this instead of .task to make available to iOS 14
                Task {
                    try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000)) // Convert seconds to nanoseconds
                    action()
                }
            }
    }
}
