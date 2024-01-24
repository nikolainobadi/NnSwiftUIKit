//
//  ErrorHandlingViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct ErrorHandlingViewModifier: ViewModifier {
    @StateObject var errorHandling = NnSwiftUIErrorHandler()

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text(currentAlert.title),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}

public extension View {
    func nnWithNnErrorHandling() -> some View {
        modifier(ErrorHandlingViewModifier())
    }
}

