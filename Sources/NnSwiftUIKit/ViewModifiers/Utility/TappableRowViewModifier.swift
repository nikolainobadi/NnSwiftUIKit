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
                .nnAsRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
                .onTapGesture(perform: onTapGesture)
        } else {
            content
                .nnAsRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
        }
    }
}
