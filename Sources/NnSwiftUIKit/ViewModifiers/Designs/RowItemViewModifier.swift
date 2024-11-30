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
    /// Configures the view as a row item with optional chevron and customizable alignment and tint.
    /// - Parameters:
    ///   - withChevron: A Boolean indicating whether to display a chevron on the right side.
    ///   - alignment: The alignment of the content within the row item, defaulting to leading.
    ///   - tint: The tint color for the chevron, defaulting to primary color.
    /// - Returns: A modified view configured as a row item.
    func asRowItem(withChevron: Bool = false, alignment: Alignment = .leading, tint: Color = .primary) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron, tint: tint, alignment: alignment))
    }
}
