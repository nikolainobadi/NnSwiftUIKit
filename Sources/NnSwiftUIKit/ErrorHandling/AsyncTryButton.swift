//
//  AsyncTryButton.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A SwiftUI view that represents a button performing an asynchronous action with error handling.
public struct AsyncTryButton<Label: View>: View {
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let role: ButtonRole?
    let label: () -> Label
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    public init(action: @escaping () async throws -> Void, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
        self.role = role
        self.hideLoadingIndicator = hideLoadingIndicator
    }
    
    public var body: some View {
        Button(role: role, action: performAction, label: label)
    }
}


// MARK: - Initializers
public extension AsyncTryButton where Label == Text {
    /// Convenience initializer for a button with a text label.
    init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, hideLoadingIndicator: hideLoadingIndicator, label: { Text(titleKey) })
    }
    
    /// Convenience initializer for a button with a string label.
    init<S>(_ title: S, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, hideLoadingIndicator: hideLoadingIndicator, label: { Text(title) })
    }
}

// MARK: - Private Methods
private extension AsyncTryButton {
    /// Performs the action associated with the button and handles loading and errors.
    func performAction() {
        context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
    }
}
