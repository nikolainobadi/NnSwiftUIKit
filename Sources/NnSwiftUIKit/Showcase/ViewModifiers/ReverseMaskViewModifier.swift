//
//  ReverseMaskViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct ReverseMaskViewModifier<ReverseContent: View>: ViewModifier {
    let alignment: Alignment
    let reverseConent: () -> ReverseContent
    
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
    func reverse<ReverseContent: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> ReverseContent) -> some View {
        modifier(ReverseMaskViewModifier(alignment: alignment, reverseConent: content))
    }
}
