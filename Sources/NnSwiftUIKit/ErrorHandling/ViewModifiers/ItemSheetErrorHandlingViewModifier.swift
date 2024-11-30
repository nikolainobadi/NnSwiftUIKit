//
//  ItemSheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/20/24.
//

import SwiftUI

/// A view modifier that presents a sheet for a specific item with error handling functionality.
struct ItemSheetErrorHandlingViewModifier<Item: Identifiable, Sheet: View>: ViewModifier {
    /// A binding that controls the item being presented in the sheet.
    @Binding var item: Item?
    
    /// Indicates whether the sheet presentation is disabled.
    let isDisabled: Bool
    
    /// The content of the sheet.
    let sheet: (Item) -> Sheet
    
    /// Modifies the content view to include an item-specific sheet with error handling.
    func body(content: Content) -> some View {
        if isDisabled {
            content
        } else {
            content
                .sheet(item: $item) { itemToShow in
                    sheet(itemToShow)
                        .withNnLoadingView()
                        .withNnErrorHandling()
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
    func sheetWithErrorHandling<Item: Identifiable, Sheet: View>(item: Binding<Item?>, isDisabled: Bool = false, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
        modifier(ItemSheetErrorHandlingViewModifier(item: item, isDisabled: isDisabled, sheet: sheet))
    }
}
