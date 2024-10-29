//
//  ReverseMaskViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

#if canImport(UIKit)
import SwiftUI

/// A view modifier that applies a reverse mask to a SwiftUI view.
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

public extension View {
    /// Applies a reverse mask to the view with specified alignment and reverse content.
    /// - Parameters:
    ///   - alignment: The alignment of the reverse content within the mask. Default is `.topLeading`.
    ///   - content: A view builder that provides the reverse content.
    /// - Returns: A view with the reverse mask applied.
    func nnReverse<ReverseContent: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> ReverseContent) -> some View {
        modifier(ReverseMaskViewModifier(alignment: alignment, reverseConent: content))
    }
}
#endif
