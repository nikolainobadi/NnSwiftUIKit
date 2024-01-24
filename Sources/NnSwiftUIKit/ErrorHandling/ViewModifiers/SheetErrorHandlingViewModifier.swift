//
//  SheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct SheetErrorHandlingViewModifier<Sheet: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let sheet: () -> Sheet
    
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
