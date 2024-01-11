//
//  NnLoadingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A ViewModifier that adds a loading state overlay to the view it modifies.
/// It creates and injects an `NnLoadingHandler` environment object into the modified view.
/// When the `isLoading` property of `NnLoadingHandler` is set to true, a loading overlay (ProgressView) is displayed.
struct NnLoadingViewModifier: ViewModifier {
    @StateObject var loadingHandler = NnLoadingHandler()

    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(loadingHandler)
            
            if loadingHandler.isLoading {
                ZStack {
                    Color.primary
                        .opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .accentColor(.white)
                        .scaleEffect(3)
                }
            }
        }
    }
}

public extension View {
    /// Function to add the `NnLoadingViewModifier` to any View.
    /// Use this to inject the `NnLoadingHandler` and add the loading state UI to a view.
    func withNnLoadingView() -> some View {
        modifier(NnLoadingViewModifier())
    }
}
