//
//  NnTryButton.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A SwiftUI button that handles errors thrown by its action.
/// The error is handled by the `NnSwiftUIErrorHandler` injected as an environment object.
public struct NnTryButton<Label>: View where Label: View {
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    var role: NnButtonRole?
    var action: () throws -> Void
    
    public init(action: @escaping () throws -> Void, role: NnButtonRole? = nil, label: @escaping () -> Label) {
        self.action = action
        self.role = role
        self.label = label
    }

    public var body: some View {
        if #available(iOS 15.0, *) {
            Button(role: role?.buttonRole, action: performAction, label: label)
        } else {
            Button(action: performAction, label: label)
        }
    }
}


// MARK: - Init
public extension NnTryButton where Label == Text {
    init(_ titleKey: LocalizedStringKey, role: NnButtonRole? = nil, action: @escaping () throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }
    
    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}


// MARK: - Private Methods
private extension NnTryButton {
    func performAction() {
        do {
            try action()
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
