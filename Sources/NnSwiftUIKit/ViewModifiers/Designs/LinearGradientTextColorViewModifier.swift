//
//  LinearGradientTextColorViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

struct LinearGradientTextColorViewModifier: ViewModifier {
    let gradient: LinearGradient
    
    func body(content: Content) -> some View {
        content
            .overlay(
                gradient.mask(content)
            )
    }
}
