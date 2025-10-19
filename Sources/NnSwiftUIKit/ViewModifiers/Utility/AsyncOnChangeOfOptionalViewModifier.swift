//
//  AsyncOnChangeOfOptionalViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/21/24.
//

#if os(iOS)
import SwiftUI

/// A view modifier that performs an asynchronous action when an optional value changes, with error handling and optional loading indicator.
struct AsyncOnChangeOfOptionalViewModifier<Item: Equatable & Sendable>: ViewModifier {
    @EnvironmentObject var context: NnErrorHandlingContext
    
    let item: Item?
    let initial: Bool
    let hideLoadingIndicator: Bool
    let action: (Item) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: item, initial: initial) { (_, value) in
                if let value {
                    context.performAction(hideLoadingIndicator: hideLoadingIndicator) {
                        try await action(value)
                    }
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
    func asyncOnChange<Item: Equatable & Sendable>(item: Item?, initial: Bool = false, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
        modifier(AsyncOnChangeOfOptionalViewModifier(item: item, initial: initial, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
#endif
