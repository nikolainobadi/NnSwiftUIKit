//
//  AsyncOpenURLViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct AsyncOpenURLViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let asyncAction: (URL) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onOpenURL { url in
                Task {
                    loadingHandler.startLoading()
                    
                    do {
                        try await asyncAction(url)
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading()
                }
            }
    }
}

public extension View {
    func asyncHandleURL(_ asyncAction: @escaping (URL) async throws -> Void) -> some View {
        modifier(AsyncOpenURLViewModifier(asyncAction: asyncAction))
    }
}
