//
//  LoadingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that displays a loading overlay over a SwiftUI view when the `isLoading` state is true.
struct LoadingViewModifier: ViewModifier {
    /// An environment object that manages the loading state.
    @StateObject var loadingHandler = NnLoadingHandler()
    
    /// Modifies the content view to include a loading overlay.
    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(loadingHandler)
            
            ZStack {
                Color.primary
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .accentColor(.white)
                    .scaleEffect(3)
            }
            .nnOnlyShow(when: loadingHandler.isLoading)
        }
    }
}

public extension View {
    func nnWithNnLoadingView() -> some View {
        modifier(LoadingViewModifier())
    }
}
