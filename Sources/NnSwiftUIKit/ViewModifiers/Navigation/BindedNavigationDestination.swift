//
//  BindedNavigationDestination.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/4/25.
//

import SwiftUI

struct BindedNavigationDestination<Item: Identifiable & Hashable, Destination: View>: ViewModifier {
    @Binding var itemList: [Item]
    @ViewBuilder var destination: (Binding<Item>) -> Destination

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Item.self) { item in
                if let index = itemList.firstIndex(where: { $0.id == item.id }) {
                    destination($itemList[index])
                }
            }
    }
}

public extension View {
    /// Creates a navigation destination that stays in sync with updates to the underlying data source.
    ///
    /// This modifier works similarly to SwiftUI’s native `.navigationDestination(for:)`,
    /// but it provides a **binding** to the navigated item instead of a read-only copy.
    /// This allows the destination view to directly modify the item within the source array,
    /// keeping the navigation stack and data model fully synchronized.
    ///
    /// It’s especially useful in master–detail interfaces where edits made in the
    /// destination view should immediately reflect in the parent list without
    /// requiring manual state propagation or index tracking.
    ///
    /// - Parameters:
    ///   - itemList: A binding to the collection of identifiable items used as the navigation source.
    ///   - destination: A closure returning the destination view for a given item binding.
    /// - Returns: A modified view that provides bound navigation destinations for items in `itemList`.
    func bindedNavigationDestination<Item: Identifiable & Hashable, Destination: View>(
        itemList: Binding<[Item]>,
        destination: @escaping (Binding<Item>) -> Destination
    ) -> some View {
        modifier(BindedNavigationDestination(itemList: itemList, destination: destination))
    }
}
