//
//  ShowcasedViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

import SwiftUI

struct ShowcasedViewModifier: ViewModifier {
    let title: String
    let orderNumber: Int
    let cornerRadius: CGFloat
    let style: RoundedCornerStyle
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds, transform: { anchor in
                return [orderNumber: .init(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)]
            })
    }
}
