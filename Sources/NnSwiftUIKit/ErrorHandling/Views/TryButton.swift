//
//  TryButton.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A SwiftUI view that represents a button performing a synchronous action with error handling.
public struct TryButton<Label>: View where Label: View {
    /// An environment object for managing error states.
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    /// The role of the button, determining its appearance and behavior.
    let role: ButtonRole?
    
    /// The label displayed on the button.
    let label: () -> Label
    
    /// The synchronous action that the button triggers.
    let action: () throws -> Void
    
    /// Initializes an `TryButton` with an action, role, and label.
    public init(action: @escaping () throws -> Void, role: ButtonRole? = nil, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.role = role
        self.label = label
    }
    
    public var body: some View {
        Button(role: role, action: performAction, label: label)
    }
}


// MARK: - Initializers
public extension TryButton where Label == Text {
    /// Convenience initializer for a button with a text label.
    init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, action: @escaping () throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }
    
    /// Convenience initializer for a button with a string label.
    init<S>(_ title: S, role: ButtonRole? = nil, action: @escaping () throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}


// MARK: - Private Methods
private extension TryButton {
    /// Performs the action associated with the button and handles errors.
    func performAction() {
        do {
            try action()
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
