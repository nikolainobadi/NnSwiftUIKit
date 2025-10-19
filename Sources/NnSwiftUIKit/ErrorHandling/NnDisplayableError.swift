//
//  NnDisplayableError.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A protocol that defines the properties of a displayable error.
public protocol NnDisplayableError: Error {
    /// The title of the error.
    var title: String { get }
    
    /// The message describing the error.
    var message: String { get }
}


public extension NnDisplayableError {
    var title: String {
        return "Error"
    }
}
