//
//  DiscardChangesViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 7/14/24.
//

#if os(iOS)
import SwiftUI

struct DiscardChangesViewModifier<Item: Equatable>: ViewModifier {
    @State private var originalItem: Item

    let title: String?
    let message: String?
    let itemToModify: Item
    let placement: ToolbarItemPlacement?
    let dismissType: NavBarDismissType?
    let dismissButtonInfo: AccessibleItemInfo?

    init(
        _ title: String?,
        itemToModify: Item,
        message: String?,
        placement: ToolbarItemPlacement?,
        dismissType: NavBarDismissType?,
        dismissButtonInfo: AccessibleItemInfo?
    ) {
        self.title = title
        self.message = message
        self.itemToModify = itemToModify
        self.placement = placement
        self.dismissType = dismissType
        self.dismissButtonInfo = dismissButtonInfo
        self._originalItem = .init(wrappedValue: itemToModify)
    }

    func body(content: Content) -> some View {
        content
            .withDiscardChangesNavBarDismissButton(
                title,
                message: message,
                placement: placement,
                didMakeChanges: itemToModify != originalItem,
                dismissType: dismissType,
                dismissButtonInfo: dismissButtonInfo
            )
    }
}

public extension View {
    /// Adds a navigation bar dismiss button with automatic change detection and confirmation dialog.
    ///
    /// **iOS only.** This is a convenience wrapper that automatically tracks changes by comparing
    /// the current item to its original state. For manual change tracking, use the overload that
    /// accepts a `didMakeChanges: Bool` parameter instead.
    ///
    /// - Parameters:
    ///   - title: The title of the confirmation dialog. Defaults to "Changes Detected".
    ///   - message: The message displayed in the confirmation dialog. Defaults to "You've made changes to this item. Would you like to discard the changes?".
    ///   - itemToModify: The item being modified. Changes are detected automatically by comparing to its initial value using `Equatable`.
    ///   - placement: The placement of the dismiss button in the navigation bar. Defaults to `.topBarLeading`.
    ///   - dismissType: The type of dismiss button (e.g., `.cancel`, `.xmark`, `.done`). Defaults to `.cancel`.
    ///   - dismissButtonInfo: Accessibility information for the "Discard Changes" button in the confirmation dialog. Defaults to `.init(prompt: "Discard Changes")`.
    /// - Returns: A modified view with a dismiss button that prompts a confirmation dialog when changes are detected.
    func withDiscardChangesNavBarDismissButton<Item: Equatable>(
        _ title: String? = nil,
        message: String? = nil,
        itemToModify: Item,
        placement: ToolbarItemPlacement? = nil,
        dismissType: NavBarDismissType? = nil,
        dismissButtonInfo: AccessibleItemInfo? = nil
    ) -> some View {
        modifier(
            DiscardChangesViewModifier(
                title,
                itemToModify: itemToModify,
                message: message,
                placement: placement,
                dismissType: dismissType,
                dismissButtonInfo: dismissButtonInfo
            )
        )
    }
}
#endif
