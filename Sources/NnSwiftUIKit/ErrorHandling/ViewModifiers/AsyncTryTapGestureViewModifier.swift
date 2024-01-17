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
    
    let asRowItem: NnAsyncTapRowItem?
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        Group {
            if let asRowItem = asRowItem {
                content
                    .asRowItem(withChevron: asRowItem == .withChevron)
            } else {
                content
            }
        }
        .onTapGesture {
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

public extension View {
    func asyncTapGesture(asRowItem: NnAsyncTapRowItem? = nil, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryTapGestureViewModifier(asRowItem: asRowItem, action: action))
    }
}


// MARK: - Dependencies
public enum NnAsyncTapRowItem {
    case noChevron, withChevron
}
