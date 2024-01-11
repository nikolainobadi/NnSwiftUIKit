//
//  NnDisplayableError.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A protocol defining an error that can be displayed to the user.
/// It requires a title and a message, which can be used to build an `NnErrorAlert`.
/// The `NnErrorAlert` is required by `NnSwiftUIErrorHandler` to display errors.
public protocol NnDisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
