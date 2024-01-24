//
//  ItemSheetErrorHandlingViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/20/24.
//

import SwiftUI

struct ItemSheetErrorHandlingViewModifier<Item: Identifiable, Sheet: View>: ViewModifier {
    @Binding var item: Item?
    
    let isDisabled: Bool
    let sheet: (Item) -> Sheet
    
    func body(content: Content) -> some View {
        if isDisabled {
            content
        } else {
            content
                .sheet(item: $item) { itemToShow in
                    sheet(itemToShow)
                        .nnWithNnLoadingView()
                        .nnWithNnErrorHandling()
                }
        }
    }
}