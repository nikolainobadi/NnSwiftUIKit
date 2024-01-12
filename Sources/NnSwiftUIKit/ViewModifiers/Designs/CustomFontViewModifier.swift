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

public extension View {
    func setCustomFont(_ style: Font.TextStyle, fontName: String, isSmooth: Bool = false, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: makeFont(style, fontName: fontName), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    func setCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: Font.custom(fontName, size: size), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
}


// MARK: - Private
private extension View {
    func makeFont(_ style: Font.TextStyle, fontName: String) -> Font {
        return Font.custom(fontName, size: makeFontSize(style))
    }
    
    func makeFontSize(_ style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle:
            return getHeightPercent(7)
        case .title:
            return getHeightPercent(6)
        case .title2:
            return getHeightPercent(4.8)
        case .title3:
            return getHeightPercent(4)
        case .headline:
            return getHeightPercent(3.5)
        case .subheadline:
            return getHeightPercent(3)
        case .body:
            return getHeightPercent(2.5)
        case .caption:
            return getHeightPercent(2)
        case .caption2:
            return getHeightPercent(1.8)
        default:
            return 8
        }
    }
}
