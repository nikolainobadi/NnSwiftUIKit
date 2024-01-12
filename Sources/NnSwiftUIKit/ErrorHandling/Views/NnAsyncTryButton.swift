//
//  NnAsyncTryButton.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

public struct NnAsyncTryButton<Label>: View where Label: View {
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let role: NnButtonRole?
    let action: () async throws -> Void
    
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


// MARK: - Init
public extension NnAsyncTryButton where Label == Text {
    init(_ titleKey: LocalizedStringKey, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }

    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}


// MARK: - Private Methods
private extension NnAsyncTryButton {
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
