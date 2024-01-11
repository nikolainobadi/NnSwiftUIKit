//
//  NnSwiftUIErrorHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// Class to handle errors and alert displays within SwiftUI.
public final class NnSwiftUIErrorHandler: ObservableObject {
    @Published var currentAlert: NnErrorAlert?
    
    public func handle(error: Error) {
        currentAlert = makeErrorAlert(from: error)
    }
}

// MARK: - Private Methods
private extension NnSwiftUIErrorHandler {
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
