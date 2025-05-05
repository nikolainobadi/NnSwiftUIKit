//
//  SheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct SheetErrorHandlingViewModifier<Sheet: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let isActive: Bool
    let accentColor: Color
    let sheet: () -> Sheet
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .sheet(isPresented: $isPresented) {
                    sheet()
                        .withNnErrorHandling(accentColor: accentColor)
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Presents a sheet with error handling functionality.
    /// - Parameters:
    ///   - isPresented: A binding controlling the presentation of the sheet.
    ///   - sheet: A closure returning the content of the sheet.
    /// - Returns: A modified view with an error-handling sheet.
    func sheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, isActive: Bool = true, accentColor: Color = .white, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(SheetErrorHandlingViewModifier(isPresented: isPresented, isActive: isActive, accentColor: accentColor, sheet: sheet))
    }
}
