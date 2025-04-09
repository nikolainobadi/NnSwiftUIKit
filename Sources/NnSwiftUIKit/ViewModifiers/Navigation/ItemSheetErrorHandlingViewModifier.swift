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
        content
            .showingConditionalView(when: isActive) {
                content
                    .sheet(item: $item) { itemToShow in
                        sheet(itemToShow)
                            .withNnErrorHandling(accentColor: accentColor)
                    }
            }
    }
}

public extension View {
    /// Presents a sheet for a specific item with error handling functionality.
    /// - Parameters:
    ///   - item: A binding to the item presented in the sheet.
    ///   - isDisabled: A Boolean indicating whether the sheet presentation is disabled.
    ///   - sheet: A closure returning the sheet content for a specific item.
    /// - Returns: A modified view with an item-specific error-handling sheet.
    func sheetWithErrorHandling<Item: Identifiable, Sheet: View>(item: Binding<Item?>, isActive: Bool = true, accentColor: Color = .white, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
        modifier(ItemSheetErrorHandlingViewModifier(item: item, isActive: isActive, accentColor: accentColor, sheet: sheet))
    }
}
