//
//  AsyncTryOnSubmitViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/4/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct AsyncTryOnSubmitViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let submitLabel: SubmitLabel
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .submitLabel(submitLabel)
            .onSubmit {
                Task {
                    loadingHandler.startLoading()
                    
                    do {
                        try await action()
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading()
                }
            }
    }
}
