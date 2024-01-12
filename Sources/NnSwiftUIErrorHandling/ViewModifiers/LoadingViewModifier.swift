//
//  LoadingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI
import NnSwiftUIHelpers

struct LoadingViewModifier: ViewModifier {
    @StateObject var loadingHandler = NnLoadingHandler()

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
            .onlyShow(when: loadingHandler.isLoading)
        }
    }
}

public extension View {
    func withNnLoadingView() -> some View {
        modifier(LoadingViewModifier())
    }
}
