//
//  ErrorHandlingViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that adds error handling to a SwiftUI view using the NnSwiftUIErrorHandler.
struct ErrorHandlingViewModifier: ViewModifier {
    /// The error handler that manages the current error state.
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
