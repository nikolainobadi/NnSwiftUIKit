//
//  CustomFontViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//


import SwiftUI

struct CustomFontViewModifier: ViewModifier {
    let font: Font
    let textColor: Color
    let autoSize: Bool
    let minimumScaleFactor: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(textColor)
            .minimumScaleFactor(autoSize ? 0.5 : 1)
    }
}


// MARK: - Helpers
internal extension View {
    func makeFont(_ style: Font.TextStyle, fontName: String) -> Font {
        return Font.custom(fontName, size: makeFontSize(style))
    }
    
    func makeFontSize(_ style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle:
            return nnGetHeightPercent(7)
        case .title:
            return nnGetHeightPercent(6)
        case .title2:
            return nnGetHeightPercent(4.8)
        case .title3:
            return nnGetHeightPercent(4)
        case .headline:
            return nnGetHeightPercent(3.5)
        case .subheadline:
            return nnGetHeightPercent(3)
        case .body:
            return nnGetHeightPercent(2.5)
        case .caption:
            return nnGetHeightPercent(2)
        case .caption2:
            return nnGetHeightPercent(1.8)
        default:
            return 8
        }
    }
}
