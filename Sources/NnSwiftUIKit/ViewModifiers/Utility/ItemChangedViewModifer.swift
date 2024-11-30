//
//  ItemChangedViewModifer.swift
//
//
//  Created by Nikolai Nobadi on 10/29/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ItemChangedViewModifer<Item: Equatable>: ViewModifier {
    @Binding var itemDidChange: Bool
    @State private var originalItem: Item
    
    let item: Item
    
    init(item: Item, itemDidChange: Binding<Bool>) {
        self.item = item
        self._itemDidChange = itemDidChange
        self._originalItem = .init(wrappedValue: item)
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: item) { _, newValue in
                itemDidChange = item != originalItem
            }
    }
}

@available(iOS 17.0, *)
public extension View {
    /// Tracks changes to a specific item and updates a binding when the item changes.
    /// - Parameters:
    ///   - item: The item to observe for changes.
    ///   - itemDidChange: A binding that indicates whether the item has changed.
    /// - Returns: A modified view that tracks changes to the specified item.
    func trackingItemChanges<I: Equatable>(item: I, itemDidChange: Binding<Bool>) -> some View {
        modifier(ItemChangedViewModifer(item: item, itemDidChange: itemDidChange))
    }
}
