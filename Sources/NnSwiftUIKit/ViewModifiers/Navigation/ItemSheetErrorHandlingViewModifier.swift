//
//  ItemSheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/20/24.
//

import SwiftUI

struct ItemSheetErrorHandlingViewModifier<Item: Identifiable, Sheet: View>: ViewModifier {
    @Binding var item: Item?
    
    let isActive: Bool
    let accentColor: Color
    let sheet: (Item) -> Sheet
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .sheet(item: $item) { itemToShow in
                    sheet(itemToShow)
                        .withNnErrorHandling(accentColor: accentColor)
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Presents a sheet bound to an identifiable item with integrated error handling.
    ///
    /// This modifier conditionally attaches a `.sheet(item:)` presentation based on `isActive`.
    /// Because SwiftUI reconstructs views when modifier chains differ, toggling `isActive`
    /// can cause reinitialization of the view hierarchy, leading to loss of local state or
    /// unexpected resets in the presented sheet—especially if the sheet content manages its own state.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**, or where the sheet content can safely
    /// be recreated when presentation toggles. For stateful views, prefer maintaining a
    /// stable `.sheet(item:)` and updating its presentation via bindings instead of
    /// conditionally removing the modifier.
    ///
    /// The sheet content automatically applies `.withNnErrorHandling()` to provide
    /// consistent alert and loading state management across the app.
    ///
    /// - Parameters:
    ///   - item: A binding to the optional identifiable item used to present the sheet.
    ///   - isActive: A Boolean controlling whether the sheet modifier is active. Defaults to `true`.
    ///   - accentColor: The accent color for the loading indicator within the error-handling context. Defaults to `.white`.
    ///   - sheet: A closure that returns the sheet content for the given item.
    /// - Returns: A modified view that presents an item-bound sheet with built-in error handling when active.
    func sheetWithErrorHandling<Item: Identifiable, Sheet: View>(
        item: Binding<Item?>,
        isActive: Bool = true,
        accentColor: Color = .white,
        @ViewBuilder sheet: @escaping (Item) -> Sheet
    ) -> some View {
        modifier(ItemSheetErrorHandlingViewModifier(item: item, isActive: isActive, accentColor: accentColor, sheet: sheet))
    }
}
