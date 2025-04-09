//
//  NnSwiftUIErrorHandler.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import Foundation

/// A class that manages error handling in a SwiftUI view by presenting an alert.
@MainActor
public final class NnSwiftUIErrorHandler: ObservableObject {
    @Published var currentAlert: NnErrorAlert?
    
    public func handle(error: Error) {
        currentAlert = .init(error: error)
    }
}
