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
    func bindedNavigationDestination<Item: Identifiable & Hashable, Destination: View>(itemList: Binding<[Item]>, destination: @escaping (Binding<Item>) -> Destination) -> some View {
        modifier(BindedNavigationDestination(itemList: itemList, destination: destination))
    }
}
