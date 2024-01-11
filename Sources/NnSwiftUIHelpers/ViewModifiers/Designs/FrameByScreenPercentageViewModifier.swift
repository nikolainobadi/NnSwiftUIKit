//
//  FrameByScreenPercentageViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct FrameByScreenPercentageViewModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: width, maxHeight: height, alignment: alignment)
    }
}

public extension View {
    func framePercent(widthPercent: CGFloat, heighPercent: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(FrameByScreenPercentageViewModifier(width: getWidthPercent(widthPercent), height: getHeightPercent(heighPercent), alignment: alignment))
    }
}
