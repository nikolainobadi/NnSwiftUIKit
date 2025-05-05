//
//  File.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/9/25.
//

import SwiftUI

/// A view modifier that provides error and loading state handling via NnErrorHandlingContext.
struct NnErrorHandlingContextModifier: ViewModifier {
    @StateObject private var context = NnErrorHandlingContext()
    
    let accentColor: Color

    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(context)
                .alert(context.alertTitle, isPresented: $context.showingAlert) {
                    Button("Okay", role: .cancel) { }
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
    /// Adds error handling functionality to the view, using `NnSwiftUIErrorHandler` for error management.
    /// - Returns: A modified view with error handling support.
    func withNnErrorHandling(accentColor: Color = .white) -> some View {
        modifier(NnErrorHandlingContextModifier(accentColor: accentColor))
    }
}
