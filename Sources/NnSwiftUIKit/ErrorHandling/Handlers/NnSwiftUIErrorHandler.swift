//
//  NnSwiftUIErrorHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A class that manages error handling in a SwiftUI view by presenting an alert.
public final class NnSwiftUIErrorHandler: ObservableObject {
    /// The current error alert being displayed.
    @Published var currentAlert: NnErrorAlert?
    
    /// Handles an error by creating and displaying an appropriate error alert.
    public func handle(error: Error) {
        Task { @MainActor in
            currentAlert = makeErrorAlert(from: error)
        }
    }
}

// MARK: - Private Methods

private extension NnSwiftUIErrorHandler {
    /// Creates an NnErrorAlert from the provided error.
    func makeErrorAlert(from error: Error) -> NnErrorAlert {
        var errorAlert = NnErrorAlert()
        
        if let customError = error as? NnDisplayableError {
            errorAlert.title = customError.title
            errorAlert.message = customError.message
        } else {
            errorAlert.title = "Error"
            errorAlert.message = error.localizedDescription
        }
        
        return errorAlert
    }
}
