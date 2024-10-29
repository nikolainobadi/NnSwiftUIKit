//
//  AsyncOnChangeOfOptionalViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/21/24.
//

import SwiftUI

/// A view modifier that performs an asynchronous action when an optional value changes, with error handling and optional loading indicator.
struct AsyncOnChangeOfOptionalViewModifier<Item: Equatable>: ViewModifier {
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// The optional item to observe for changes.
    let item: Item?
    
    /// Indicates whether the loading indicator should be hidden during the action.
    let hideLoadingIndicator: Bool
    
    /// The asynchronous action to perform when the item changes.
    let action: (Item) async throws -> Void
    
    /// Modifies the content view to perform an asynchronous action on item change.
    func body(content: Content) -> some View {
        content
            .onChange(of: item) { value in
                guard let value = value else { return }
                
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await action(value)
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    func nnAsyncOnChange<Item: Equatable>(of item: Item?, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
        modifier(AsyncOnChangeOfOptionalViewModifier(item: item, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
