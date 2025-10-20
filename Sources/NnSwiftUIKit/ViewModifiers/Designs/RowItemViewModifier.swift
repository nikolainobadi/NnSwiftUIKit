//
//  RowItemViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

struct RowItemViewModifier: ViewModifier {
    @Environment(\.rowItemTint) private var environmentTint

    let tint: Color?
    let maxWidth: CGFloat
    let withChevron: Bool
    let alignment: Alignment

    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: maxWidth, alignment: alignment)

            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(tint ?? environmentTint)
            }
        }
        .contentShape(.rect)
    }
}

public extension View {
    /// Applies a horizontal layout to the view, optionally adding a chevron and setting alignment, tint, and max width.
    ///
    /// - Parameters:
    ///   - withChevron: A Boolean value indicating whether to display a chevron on the trailing side. Defaults to `false`.
    ///   - maxWidth: The maximum width the view can occupy. Defaults to `.infinity`.
    ///   - alignment: The horizontal alignment for the content. Defaults to `.leading`.
    ///   - tint: The color used for the chevron, if displayed. If `nil`, uses the environment's `rowItemTint` value. Defaults to `nil`.
    func asRowItem(
        withChevron: Bool = false,
        maxWidth: CGFloat = .infinity,
        alignment: Alignment = .leading,
        tint: Color? = nil
    ) -> some View {
        modifier(
            RowItemViewModifier(
                tint: tint,
                maxWidth: maxWidth,
                withChevron: withChevron,
                alignment: alignment
            )
        )
    }
}
