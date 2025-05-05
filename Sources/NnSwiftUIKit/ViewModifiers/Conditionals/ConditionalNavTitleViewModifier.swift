//
//  ConditionalNavTitleViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that conditionally adds a navigation title to a SwiftUI view.
struct ConditionalNavTitleViewModifier: ViewModifier {
    let title: String?
    
    func body(content: Content) -> some View {
        if let title {
            content
                .navigationTitle(title)
        } else {
            content
        }
    }
}

public extension View {
    /// Conditionally sets a navigation title if a title is provided.
    /// - Parameter title: An optional string to use as the navigation title.
    /// - Returns: A modified view with a navigation title if the title is non-nil.
    func withNavTitle(title: String?) -> some View {
        modifier(ConditionalNavTitleViewModifier(title: title))
    }
}
