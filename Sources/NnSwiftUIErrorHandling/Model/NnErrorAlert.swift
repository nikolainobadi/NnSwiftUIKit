//
//  NnErrorAlert.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A struct defining an alert that displays an error.
/// It uses the properties defined in the NnDisplayableError protocol
/// to present an error in an alert controlled by the NnSwiftUIErrorHandler.
struct NnErrorAlert: Identifiable {
    var id = UUID()
    var title: String = "Error"
    var message: String = ""
    var dismissAction: (() -> Void)?
}
