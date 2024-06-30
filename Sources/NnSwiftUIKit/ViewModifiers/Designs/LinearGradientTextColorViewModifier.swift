//
//  LinearGradientTextColorViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct LinearGradientTextColorViewModifier: ViewModifier {
    let gradientType: NnGradientType
    
    func body(content: Content) -> some View {
        content
            .overlay(
                gradientType.linearGradient
                    .mask(content)
            )
    }
}


// MARK: - Dependencies

