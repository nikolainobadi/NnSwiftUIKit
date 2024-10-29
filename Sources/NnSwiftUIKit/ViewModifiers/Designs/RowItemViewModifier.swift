//
//  RowItemViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a row item, optionally with a chevron and customizable alignment and tint.
struct RowItemViewModifier: ViewModifier {
    /// A boolean value indicating whether to display a chevron on the right side.
    let withChevron: Bool
    
    /// The tint color for the chevron.
    let tint: Color
    
    /// The alignment of the content within the row item.
    let alignment: Alignment
    
    /// Modifies the content view to configure it as a row item.
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: .infinity, alignment: alignment)
            
            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(tint)
            }
        }
        .contentShape(Rectangle())
    }
}

public extension View {
    func nnAsRowItem(withChevron: Bool = false, alignment: Alignment = .leading, tint: Color = .primary) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron, tint: tint, alignment: alignment))
    }
}
