//
//  AsyncTaskOnAppearViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct AsyncTaskOnAppearViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let delay: Double
    let hideLoadingIndicator: Bool
    let asyncAction: () async throws -> Void
    
    private func configureLoading(startLoading: Bool) {
        if hideLoadingIndicator { return }
        
        if startLoading {
            loadingHandler.startLoading()
        } else {
            loadingHandler.stopLoading()
        }
    }
    
    func body(content: Content) -> some View {
        content
            .delayedOnAppear(seconds: delay) {
                Task {
                    configureLoading(startLoading: true)
                    
                    do {
                        try await asyncAction()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    configureLoading(startLoading: false)
                }
            }
    }
}

public extension View {
    func asyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
