//
//  TappableRowViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a tappable row item with customizable appearance and behavior.
struct TappableRowViewModifier: ViewModifier {
    /// A boolean value indicating whether the tap action is active.
    let tapIsActive: Bool
    
    /// A boolean value indicating whether to display a chevron on the right side.
    let withChevron: Bool
    
    /// The tint color for the chevron.
    let tint: Color
    
    /// The alignment of the content within the row item.
    let alignment: Alignment
    
    /// The action to perform when the row is tapped.
    let onTapGesture: () -> Void
    
    /// Modifies the content view to configure it as a tappable row item with the specified settings.
    func body(content: Content) -> some View {
        if tapIsActive {
            content
                .asRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
                .onTapGesture(perform: onTapGesture)
        } else {
            content
                .asRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
        }
    }
}

public extension View {
    /// Configures the view as a tappable row item with customizable appearance and behavior.
    /// - Parameters:
    ///   - tapIsActive: A Boolean indicating whether the tap action is active.
    ///   - withChevron: A Boolean indicating if a chevron should be displayed on the right.
    ///   - tint: The tint color for the chevron, defaulting to primary.
    ///   - alignment: The alignment of the content within the row item, defaulting to leading.
    ///   - onTapGesture: The action to perform when the row is tapped.
    /// - Returns: A modified view configured as a tappable row item.
    func tappable(tapIsActive: Bool = true, withChevron: Bool = false, tint: Color = .primary, alignment: Alignment = .leading, onTapGesture: @escaping () -> Void) -> some View {
        modifier(TappableRowViewModifier(tapIsActive: tapIsActive, withChevron: withChevron, tint: tint, alignment: alignment, onTapGesture: onTapGesture))
    }
}
