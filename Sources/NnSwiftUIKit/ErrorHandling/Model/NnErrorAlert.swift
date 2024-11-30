//
//  NnErrorAlert.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A struct representing an error alert with a title, message, and an optional dismiss action.
struct NnErrorAlert: Identifiable {
    /// The unique identifier for the alert.
    var id = UUID()
    
    /// The title of the alert. Default is "Error".
    var title: String = "Error"
    
    /// The message to be displayed in the alert.
    var message: String = ""
    
    /// An optional action that is triggered when the alert is dismissed.
    var dismissAction: (() -> Void)?
}
