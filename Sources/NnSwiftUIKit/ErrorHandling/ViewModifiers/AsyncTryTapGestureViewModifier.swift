//
//  AsyncTryTapGestureViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that adds a tap gesture to a SwiftUI view, performing an asynchronous action with error handling.
struct AsyncTryTapGestureViewModifier: ViewModifier {
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// An optional configuration for displaying the view as a row item with or without a chevron.
    let asRowItem: NnAsyncTapRowItem?
    
    /// The asynchronous action to perform when the view is tapped.
    let action: () async throws -> Void
    
    /// Modifies the content view to include a tap gesture with asynchronous error handling.
    func body(content: Content) -> some View {
        Group {
            if let asRowItem = asRowItem {
                content
                    .nnAsRowItem(withChevron: asRowItem == .withChevron)
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
    func nnAsyncTapGesture(asRowItem: NnAsyncTapRowItem? = nil, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryTapGestureViewModifier(asRowItem: asRowItem, action: action))
    }
}


// MARK: - Dependencies
/// Enum for specifying whether a row item should display a chevron or not.
public enum NnAsyncTapRowItem {
    case noChevron, withChevron
}

