//
//  NnLoadingHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A class to handle loading state within SwiftUI.
/// This class is designed to be used as an environment object, providing a `isLoading` state that can be observed by views.
/// It is especially useful in conjunction with the `NnAsyncTryButton` which starts and stops loading state while handling async throws methods.
public final class NnLoadingHandler: ObservableObject {
    @Published var isLoading: Bool = false
    
    public func startLoading() {
        isLoading = true
    }

    public func stopLoading() {
        isLoading = false
    }
}
