//
//  NnLoadingHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A class that manages the loading state in a SwiftUI view.
@MainActor
public final class NnLoadingHandler: ObservableObject {
    @Published var isLoading: Bool = false
}

public extension NnLoadingHandler {
    func startLoading(isDisabled: Bool = false) {
        configureLoading(isLoading: true, isDisabled: isDisabled)
    }
    
    func stopLoading(isDisabled: Bool = false) {
        configureLoading(isLoading: false, isDisabled: isDisabled)
    }
}


// MARK: - Private Methods
private extension NnLoadingHandler {
    /// Configures the loading state based on the provided parameters.
    func configureLoading(isLoading: Bool, isDisabled: Bool) {
        if !isDisabled {
            self.isLoading = isLoading
        }
    }
}
