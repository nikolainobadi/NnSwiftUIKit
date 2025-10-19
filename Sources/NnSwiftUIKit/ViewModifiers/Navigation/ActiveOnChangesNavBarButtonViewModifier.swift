//
//  ActiveOnChangesNavBarButtonViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/4/25.
//

#if os(iOS)
import SwiftUI

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

public extension View {
    /// Adds a navigation bar button that automatically activates when a specified item changes.
    ///
    /// This modifier observes an `Equatable` item for changes and sets the navigation bar button
    /// to an active state whenever the item’s value updates. It’s useful for cases such as enabling
    /// a “Save” or “Update” button only when data has changed.
    ///
    /// The button integrates with the app’s async error-handling system through
    /// `.withNavBarButton`, ensuring that any async actions triggered from the button
    /// are wrapped with consistent error and loading state management.
    ///
    /// - Parameters:
    ///   - item: The item whose changes will activate the button.
    ///   - font: The font used for the button label. Defaults to `.title2`.
    ///   - textColor: The color of the button text or icon. Defaults to `.primary`.
    ///   - accessibilityId: An optional accessibility identifier for UI testing. Defaults to `nil`.
    ///   - placement: The toolbar placement of the navigation bar button. Defaults to `.topBarTrailing`.
    ///   - buttonContent: The content describing the button’s label or icon.
    ///   - action: The asynchronous action executed when the button is tapped.
    /// - Returns: A modified view containing a navigation bar button that activates when the item changes.
    func activeOnChangeNavBarButton<Item: Equatable>(
        item: Item,
        font: Font = .title2,
        textColor: Color = .primary,
        accessibilityId: String? = nil,
        placement: ToolbarItemPlacement = .topBarTrailing,
        buttonContent: NavBarButtonContent,
        action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            ActiveOnChangesNavBarButtonViewModifier(
                item: item,
                font: font,
                textColor: textColor,
                accessibilityId: accessibilityId,
                placement: placement,
                buttonContent: buttonContent,
                action: action
            )
        )
    }
}
#endif
