//
//  SheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that presents a sheet with error handling functionality.
struct SheetErrorHandlingViewModifier<Sheet: View>: ViewModifier {
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
    /// Presents a sheet with error handling functionality.
    /// - Parameters:
    ///   - isPresented: A binding controlling the presentation of the sheet.
    ///   - sheet: A closure returning the content of the sheet.
    /// - Returns: A modified view with an error-handling sheet.
    func sheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(SheetErrorHandlingViewModifier(isPresented: isPresented, sheet: sheet))
    }
}
