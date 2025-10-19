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
    /// Presents a sheet that automatically includes error-handling capabilities.
    ///
    /// This modifier conditionally attaches a `.sheet` presentation to the view based on `isActive`.
    /// Because SwiftUI reconstructs view hierarchies when modifier chains differ, toggling
    /// `isActive` can lead to view reinitialization, loss of local state, or unexpected
    /// behavior in the presented sheet—especially if the sheet content owns its own state.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**, or when the sheet content can
    /// safely be recreated as needed. For stateful workflows, prefer maintaining a stable
    /// `.sheet` modifier and controlling presentation purely via the `isPresented` binding.
    ///
    /// The presented sheet automatically applies `.withNnErrorHandling()` to handle loading
    /// and alert states consistently across the app.
    ///
    /// - Parameters:
    ///   - isPresented: A binding controlling whether the sheet is currently presented.
    ///   - isActive: A Boolean controlling whether the sheet modifier itself is applied. Defaults to `true`.
    ///   - accentColor: The accent color applied to the loading indicator within the error-handling context. Defaults to `.white`.
    ///   - sheet: A closure returning the view to present as a sheet.
    /// - Returns: A modified view that presents a sheet with built-in error handling when active.
    func sheetWithErrorHandling<Sheet: View>(
        isPresented: Binding<Bool>,
        isActive: Bool = true,
        accentColor: Color = .white,
        @ViewBuilder sheet: @escaping () -> Sheet
    ) -> some View {
        modifier(SheetErrorHandlingViewModifier(isPresented: isPresented, isActive: isActive, accentColor: accentColor, sheet: sheet))
    }
}
