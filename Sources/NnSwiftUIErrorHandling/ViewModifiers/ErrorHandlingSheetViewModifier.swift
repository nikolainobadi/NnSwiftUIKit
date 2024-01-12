//
//  ErrorHandlingSheetViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct ErrorHandlingSheetViewModifier<Sheet: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let sheet: () -> Sheet
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                sheet()
                    .withNnLoadingView()
                    .withNnErrorHandling()
            }
    }
}

public extension View {
    func sheetWithErrorHandling() -> some View {
        modifier(ErrorHandlingViewModifier())
    }
}
