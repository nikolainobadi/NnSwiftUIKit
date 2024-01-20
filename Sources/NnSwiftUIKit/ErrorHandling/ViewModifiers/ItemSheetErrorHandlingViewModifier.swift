//
//  ItemSheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/20/24.
//

import SwiftUI

struct ItemSheetErrorHandlingViewModifier<Item: Identifiable & Hashable, Sheet: View>: ViewModifier {
    @Binding var item: Item?
    
    let sheet: (Item) -> Sheet
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $item) { itemToShow in
                sheet(itemToShow)
                    .withNnLoadingView()
                    .withNnErrorHandling()
            }
    }
}

public extension View {
    func sheetWithErrorHandling<Item: Identifiable & Hashable, Sheet: View>(item: Binding<Item?>, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
        modifier(ItemSheetErrorHandlingViewModifier(item: item, sheet: sheet))
    }
}
