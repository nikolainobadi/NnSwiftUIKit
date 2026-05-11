//
//  TabItemViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/10/26.
//

import SwiftUI

struct TabItemViewModifier<Item: NnTabItem>: ViewModifier {
    let item: Item

    func body(content: Content) -> some View {
        content
            .tabItem {
                Label(item.name, systemImage: item.imageName)
                    .setOptionalAccessibiltyId(item.accessibilityId)
            }
            .tag(item.tag)
    }
}

public extension View {
    /// Configures this view as a tab in a `TabView` using an `NnTabItem`.
    ///
    /// Applies a `Label(name, systemImage: imageName)` to `.tabItem`, attaches the
    /// item's `tag` for selection binding, and sets the optional accessibility
    /// identifier on the label when provided.
    ///
    /// - Parameter item: The tab descriptor conforming to ``NnTabItem``.
    /// - Returns: A view configured as the described tab.
    func asTabItem<Item: NnTabItem>(_ item: Item) -> some View {
        modifier(TabItemViewModifier(item: item))
    }
}

/// A type that describes a tab in a `TabView`.
///
/// Conform an enum or struct to `NnTabItem` and apply it to a tab's root view with
/// `.asTabItem(_:)` to consistently configure the `tabItem` label and `tag`.
public protocol NnTabItem {
    associatedtype Tag: Hashable

    /// Display name shown in the tab bar.
    var name: String { get }

    /// SF Symbol name for the tab's icon.
    var imageName: String { get }

    /// Hashable value used as the tab's `.tag` for selection binding.
    var tag: Tag { get }

    /// Optional accessibility identifier applied to the tab's label.
    var accessibilityId: String? { get }
}

public extension NnTabItem {
    var accessibilityId: String? { nil }
}
