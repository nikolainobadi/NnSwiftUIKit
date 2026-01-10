//
//  EmptyListViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/5/26.
//

import SwiftUI

struct EmptyListViewModifier: ViewModifier {
    let title: String
    let message: String
    let systemImage: String
    let listEmpty: Bool
    
    func body(content: Content) -> some View {
        if listEmpty {
            VStack {
                Image(systemName: systemImage)
                    .withFont(.title)
                
                Text(title)
                    .withFont(.title, layout: .autoSize)
                
                Text(message)
                    .withFont(isDetail: true)
                    .multilineTextAlignment(.center)
            }
            .padding()
        } else {
            content
        }
    }
}

public extension View {
    /// Conditionally displays an empty state placeholder when a list has no items.
    ///
    /// When `listEmpty` is `true`, this modifier replaces the content with a centered empty state view
    /// showing a system image, title, and message. When `false`, the original content is displayed unchanged.
    ///
    /// - Parameters:
    ///   - title: The main heading text for the empty state (e.g., "No Items", "List is Empty").
    ///   - message: A descriptive message explaining the empty state or suggesting actions (e.g., "Add your first item to get started").
    ///   - systemImage: The SF Symbol name to display above the text. Defaults to `"tray"`.
    ///   - listEmpty: A Boolean indicating whether the list is empty. When `true`, shows the empty state; when `false`, shows the content.
    /// - Returns: Either an empty state placeholder view or the original content, depending on the `listEmpty` condition.
    func withEmptyListView(title: String, message: String, systemImage: String = "tray", listEmpty: Bool) -> some View {
        modifier(EmptyListViewModifier(title: title, message: message, systemImage: systemImage, listEmpty: listEmpty))
    }
}
