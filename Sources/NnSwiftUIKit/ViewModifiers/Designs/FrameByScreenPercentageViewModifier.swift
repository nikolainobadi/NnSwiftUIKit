//
//  FrameByScreenPercentageViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that configures the frame of a SwiftUI view based on a percentage of the screen width and height.
struct FrameByScreenPercentageViewModifier: ViewModifier {
    /// The width of the view as a percentage of the screen width.
    let width: CGFloat
    
    /// The height of the view as a percentage of the screen height.
    let height: CGFloat
    
    /// The alignment of the content within the view.
    let alignment: Alignment
    
    /// Modifies the content view to set its frame based on the specified width and height percentages.
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: width, maxHeight: height, alignment: alignment)
    }
}

