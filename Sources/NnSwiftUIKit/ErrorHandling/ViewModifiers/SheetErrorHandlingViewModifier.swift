//
//  SheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that presents a sheet with error handling functionality.
struct SheetErrorHandlingViewModifier<Sheet: View>: ViewModifier {
    /// A binding that controls whether the sheet is presented.
    @Binding var isPresented: Bool
    
    /// The content of the sheet.
    let sheet: () -> Sheet
    
    /// Modifies the content view to include a sheet with error handling.
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                sheet()
                    .nnWithNnLoadingView()
                    .nnWithNnErrorHandling()
            }
    }
}

public extension View {
    func nnSheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(SheetErrorHandlingViewModifier(isPresented: isPresented, sheet: sheet))
    }
}
