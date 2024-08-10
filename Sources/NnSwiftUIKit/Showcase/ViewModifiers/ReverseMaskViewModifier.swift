//
//  ReverseMaskViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

import SwiftUI

/// A view modifier that applies a reverse mask to a SwiftUI view.
@available(iOS 15.0, *)
struct ReverseMaskViewModifier<ReverseContent: View>: ViewModifier {
    /// The alignment of the reverse content within the mask.
    let alignment: Alignment
    
    /// The reverse content to be used as the mask.
    let reverseConent: () -> ReverseContent
    
    /// Modifies the content view to apply a reverse mask.
    func body(content: Content) -> some View {
        content
            .mask {
                Rectangle()
                    .overlay(alignment: alignment) {
                        reverseConent()
                            .blendMode(.destinationOut)
                    }
            }
    }
}

@available(iOS 15.0, *)
extension View {
    /// Applies a reverse mask to the view with specified alignment and reverse content.
    /// - Parameters:
    ///   - alignment: The alignment of the reverse content within the mask. Default is `.topLeading`.
    ///   - content: A view builder that provides the reverse content.
    /// - Returns: A view with the reverse mask applied.
    func reverse<ReverseContent: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> ReverseContent) -> some View {
        modifier(ReverseMaskViewModifier(alignment: alignment, reverseConent: content))
    }
}
