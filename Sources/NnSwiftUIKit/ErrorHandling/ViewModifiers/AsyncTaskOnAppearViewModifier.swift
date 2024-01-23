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
    
    func body(content: Content) -> some View {
        content
            .delayedOnAppear(seconds: delay) {
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await asyncAction()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    func asyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
}
