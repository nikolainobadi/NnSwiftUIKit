//
//  ActiveOnChangesNavBarButtonViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/4/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ActiveOnChangesNavBarButtonViewModifier<Item: Equatable>: ViewModifier {
    @State private var itemDidChange = false
    
    let item: Item
    let font: Font
    let textColor: Color
    let accessibilityId: String?
    let placement: ToolbarItemPlacement
    let buttonContent: NavBarButtonContent
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .trackingItemChanges(item: item, itemDidChange: $itemDidChange)
            .withNavBarButton(placement: placement, buttonContent: buttonContent, font: font, textColor: textColor, isActive: itemDidChange, accessibilityId: accessibilityId, action: action)
    }
}

@available(iOS 17.0, *)
public extension View {
    func activeOnChangeNavBarButton<Item: Equatable>(item: Item, font: Font = .title2, textColor: Color = .primary, accessibilityId: String? = nil, placement: ToolbarItemPlacement = .topBarTrailing, buttonContent: NavBarButtonContent, action: @escaping () async throws -> Void) -> some View {
        modifier(ActiveOnChangesNavBarButtonViewModifier(item: item, font: font, textColor: textColor, accessibilityId: accessibilityId, placement: placement, buttonContent: buttonContent, action: action))
    }
}
