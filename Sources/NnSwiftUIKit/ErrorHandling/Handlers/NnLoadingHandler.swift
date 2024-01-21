//
//  NnLoadingHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

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
    func configureLoading(isLoading: Bool, isDisabled: Bool) {
        guard !isDisabled else { return }
        
        self.isLoading = isLoading
    }
}
