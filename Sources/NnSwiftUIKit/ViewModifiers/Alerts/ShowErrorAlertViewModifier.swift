//
//  ShowErrorAlertViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/27/25.
//

import SwiftUI

struct ShowErrorAlertViewModifier: ViewModifier {
    @Binding var error: Error?

    func body(content: Content) -> some View {
        content
            .showingAlert(
                error?.message ?? "Error",
                message: error?.localizedDescription ?? "An unknown error has occured",
                isPresented: .constant(error != nil)
            )
    }
}

public extension View {
    /// Displays an alert automatically when the bound `Error?` becomes non-nil.
    ///
    /// The alert shows the localized description of the error and dismisses it when the user taps "OK".
    /// After dismissal, the `error` binding is reset to `nil`.
    ///
    /// - Parameter error: A binding to an optional `Error`. When non-nil, an alert is presented.
    func showingError(error: Binding<Error?>) -> some View {
        modifier(ShowErrorAlertViewModifier(error: error))
    }
}


// MARK: - Extension Dependencies
extension Error {
    var title: String {
        return displayable?.title ?? "Error"
    }
    
    var message: String {
        return displayable?.message ?? localizedDescription
    }
    
    var displayable: NnDisplayableError? {
        return self as? NnDisplayableError
    }
}
