//
//  NnLoadingHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

public final class NnLoadingHandler: ObservableObject {
    @Published var isLoading: Bool = false
    
    public func startLoading() {
        isLoading = true
    }

    public func stopLoading() {
        isLoading = false
    }
}
