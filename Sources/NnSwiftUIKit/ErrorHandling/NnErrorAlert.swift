//
//  NnErrorAlert.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A struct representing an error alert with a title, message, and an optional dismiss action.
struct NnErrorAlert: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var dismissAction: (() -> Void)?
}

extension NnErrorAlert {
    init(error: Error) {
        if let customError = error as? NnDisplayableError {
            title = customError.title
            message = customError.message
        } else {
            title = "Error"
            message = error.localizedDescription
        }
    }
}
