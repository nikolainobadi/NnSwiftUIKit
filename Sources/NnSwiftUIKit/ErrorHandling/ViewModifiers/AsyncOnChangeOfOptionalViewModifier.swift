//
//  AsyncOnChangeOfOptionalViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/21/24.
//

import SwiftUI

/// A view modifier that performs an asynchronous action when an optional value changes, with error handling and optional loading indicator.
struct AsyncOnChangeOfOptionalViewModifier<Item: Equatable>: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let item: Item?
    let hideLoadingIndicator: Bool
    let action: (Item) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: item) { value in
                guard let value = value else { return }
                
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await action(value)
                    } catch {
                        await errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}

public extension View {
    /// Performs an asynchronous action when an optional value changes, with error handling.
    /// - Parameters:
    ///   - item: The optional item to observe for changes.
    ///   - hideLoadingIndicator: A Boolean indicating whether to hide the loading indicator during the action.
    ///   - action: The asynchronous action to perform when the item changes.
    /// - Returns: A modified view that handles asynchronous actions on item changes.
    func asyncOnChange<Item: Equatable>(of item: Item?, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
        modifier(AsyncOnChangeOfOptionalViewModifier(item: item, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
