//
//  NnAsyncTryButton.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A SwiftUI view that represents a button performing an asynchronous action with error handling.
public struct NnAsyncTryButton<Label>: View where Label: View {
    /// The label displayed on the button.
    @ViewBuilder var label: () -> Label
    
    /// An environment object for managing loading states.
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// The role of the button, determining its appearance and behavior.
    let role: NnButtonRole?
    
    /// The asynchronous action that the button triggers.
    let action: () async throws -> Void
    
    /// Initializes an NnAsyncTryButton with an action, role, and label.
    public init(action: @escaping () async throws -> Void, role: NnButtonRole? = nil, label: @escaping () -> Label) {
        self.action = action
        self.label = label
        self.role = role
    }
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            Button(role: role?.buttonRole, action: performAction, label: label)
        } else {
            Button(action: performAction, label: label)
        }
    }
}

// MARK: - Initializers

public extension NnAsyncTryButton where Label == Text {
    /// Convenience initializer for a button with a text label.
    init(_ titleKey: LocalizedStringKey, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }
    
    /// Convenience initializer for a button with a string label.
    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}

// MARK: - Private Methods

private extension NnAsyncTryButton {
    /// Performs the action associated with the button and handles loading and errors.
    func performAction() {
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
