//
//  NnLoadingHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A class that manages the loading state in a SwiftUI view.
public final class NnLoadingHandler: ObservableObject {
    /// A published property that indicates whether loading is in progress.
    @Published var isLoading: Bool = false
}

public extension NnLoadingHandler {
    /// Starts the loading process and optionally disables further actions.
    func startLoading(isDisabled: Bool = false) {
        configureLoading(isLoading: true, isDisabled: isDisabled)
    }
    
    /// Stops the loading process and optionally re-enables actions.
    func stopLoading(isDisabled: Bool = false) {
        configureLoading(isLoading: false, isDisabled: isDisabled)
    }
}

// MARK: - Private Methods

private extension NnLoadingHandler {
    /// Configures the loading state based on the provided parameters.
    func configureLoading(isLoading: Bool, isDisabled: Bool) {
        guard !isDisabled else { return }
        
        Task { @MainActor in
            self.isLoading = isLoading
        }
    }
}

