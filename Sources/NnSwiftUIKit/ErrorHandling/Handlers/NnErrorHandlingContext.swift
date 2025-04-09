//
//  NnErrorHandlingContext.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/9/25.
//

import Foundation

@MainActor
public final class NnErrorHandlingContext: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showingAlert: Bool = false
    @Published var currentAlert: NnErrorAlert? {
        didSet {
            showingAlert = currentAlert != nil
        }
    }
}


// MARK: - Display Data
extension NnErrorHandlingContext {
    var alertTitle: String {
        return currentAlert?.title ?? "Error"
    }
    
    var alertMessage: String {
        return currentAlert?.message ?? "Something went wrong."
    }
}


// MARK: - Action
public extension NnErrorHandlingContext {
    func performAction(hideLoadingIndicator: Bool, action: @escaping () async throws -> Void) {
        Task {
            configureLoading(isLoading: true, hideLoadingIndicator: hideLoadingIndicator)
            
            do {
                try await action()
            } catch {
                currentAlert = .init(error: error)
            }
            
            configureLoading(isLoading: false, hideLoadingIndicator: hideLoadingIndicator)
        }
    }
}


// MARK: - Private Methods
private extension NnErrorHandlingContext {
    func configureLoading(isLoading: Bool, hideLoadingIndicator: Bool) {
        if !hideLoadingIndicator {
            self.isLoading = isLoading
        }
    }
}
