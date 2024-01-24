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
