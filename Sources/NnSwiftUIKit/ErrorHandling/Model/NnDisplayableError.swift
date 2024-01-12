//
//  NnDisplayableError.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

public protocol NnDisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
