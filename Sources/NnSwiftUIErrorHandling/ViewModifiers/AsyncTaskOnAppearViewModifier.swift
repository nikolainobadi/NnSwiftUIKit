//
//  AsyncTaskOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI
import NnSwiftUIHelpers

struct AsyncTaskOnAppearViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let delay: Double
    let asyncAction: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .delayedOnAppear(seconds: delay) {
                Task {
                    loadingHandler.startLoading()
                    
                    do {
                        try await asyncAction()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading()
                }
            }
    }
}

public extension View {
    func asyncTask(delay: Double = 0, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, asyncAction: asyncAction))
    }
}

