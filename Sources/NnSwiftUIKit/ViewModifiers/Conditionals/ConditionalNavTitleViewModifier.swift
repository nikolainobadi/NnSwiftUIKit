//
//  ConditionalNavTitleViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

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
    /// Conditionally applies a navigation title to the view when `title` is non-nil.
    ///
    /// This modifier changes the view hierarchy whenever the presence of a title changes.
    /// Because SwiftUI rebuilds views when modifier chains differ, toggling between
    /// `nil` and non-`nil` titles can cause reinitialization of the view and loss of local state.
    ///
    /// To avoid unexpected resets or re-rendering behavior, it is recommended to use this modifier
    /// **only on stateless views** or those that **do not own their own source of truth**.
    /// For stateful containers, prefer keeping a consistent `.navigationTitle("")` and updating
    /// its value reactively instead of conditionally.
    ///
    /// - Parameter title: An optional string to use as the navigation title.
    /// - Returns: A modified view with a navigation title when `title` is provided.
    func withNavTitle(title: String?) -> some View {
        modifier(ConditionalNavTitleViewModifier(title: title))
    }
}
