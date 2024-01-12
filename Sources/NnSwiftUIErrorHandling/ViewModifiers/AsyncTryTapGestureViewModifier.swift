//
//  AsyncTryTapGestureViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct AsyncTryTapGestureViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                loadingHandler.startLoading()
                
                Task {
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


public extension View {
    func asyncTapGesture(action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryTapGestureViewModifier(action: action))
    }
}
