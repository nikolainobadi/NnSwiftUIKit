//
//  NnErrorHandlingContextModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/9/25.
//

import SwiftUI

struct NnErrorHandlingContextModifier: ViewModifier {
    @StateObject private var context = NnErrorHandlingContext()
    
    let accentColor: Color
    let alertButtonText: String

    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(context)
                .alert(context.alertTitle, isPresented: $context.showingAlert) {
                    Button(alertButtonText, role: .cancel) { }
                        .keyboardShortcut(.defaultAction)
                } message: {
                    Text(context.alertMessage)
                }

            if context.isLoading {
                ZStack {
                    Color.primary
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .accentColor(accentColor)
                        .scaleEffect(3)
                }
            }
        }
    }
}

public extension View {
    /// Adds built-in error and loading state handling to the view using an internal `NnErrorHandlingContext`.
    ///
    /// This modifier simplifies presentation of common app states:
    /// - Displays an alert when an error is reported through the shared context.
    /// - Shows a dimmed background with a loading spinner when an async process is in progress.
    ///
    /// Apply this to top-level views (e.g., screen containers) to enable global handling.
    ///
    /// - Parameters:
    ///   - accentColor: The tint color used for the `ProgressView` spinner. Defaults to `.white`.
    ///   - alertButtonText: The text for the alert dismissal button. Defaults to `"Okay"`.
    ///
    /// - Returns: A new view enhanced with error and loading state management.
    func withNnErrorHandling(accentColor: Color = .white, alertButtonText: String = "Okay") -> some View {
        modifier(NnErrorHandlingContextModifier(accentColor: accentColor, alertButtonText: alertButtonText))
    }
}
