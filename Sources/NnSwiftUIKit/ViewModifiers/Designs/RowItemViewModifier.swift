//
//  RowItemViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a row item, optionally with a chevron and customizable alignment and tint.
struct RowItemViewModifier: ViewModifier {
    let withChevron: Bool
    let tint: Color
    let maxWidth: CGFloat
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: maxWidth, alignment: alignment)
            
            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(tint)
            }
        }
        .contentShape(.rect)
    }
}

public extension View {
    func asRowItem(withChevron: Bool = false, maxWidth: CGFloat = .infinity, alignment: Alignment = .leading, tint: Color = .primary) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron, tint: tint, maxWidth: maxWidth, alignment: alignment))
    }
}
