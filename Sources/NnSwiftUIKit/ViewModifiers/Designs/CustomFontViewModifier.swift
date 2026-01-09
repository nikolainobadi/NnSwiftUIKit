//
//  CustomFontViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/9/26.
//

import SwiftUI

struct CustomFontViewModifier: ViewModifier {
    @Environment(\.fontSizeProvider) private var provider
    @Environment(\.fontConfiguration) private var configuration
    
    let source: Source
    let textColor: Color?
    let textLayout: NnTextLayout?
    
    func body(content: Content) -> some View {
        Group {
            switch resolvedLayout {
            case .unlimited:
                content
                    .fixedSize(horizontal: false, vertical: true)
            case .multiLine(let limit):
                content
                    .lineLimit(limit)
            case .singleLineAutoSize(let minScale):
                content
                    .lineLimit(1)
                    .minimumScaleFactor(minScale)
            }
        }
        .font(resolvedFont)
        .foregroundStyle(textColor ?? configuration.textColor)
    }
}

extension CustomFontViewModifier {
    enum Source: Sendable {
        case explicit(Font)
        case dynamic(style: Font.TextStyle, isDetail: Bool, screenSize: CGSize)
        case fontName(style: Font.TextStyle, fontName: String, screenSize: CGSize)
    }
}

private extension CustomFontViewModifier {
    var resolvedFont: Font {
        switch source {
        case .explicit(let font):
            return font
        case .fontName(let style, let fontName, let screenSize):
            return provider.makeFont(style, fontName: fontName, screenSize: screenSize)
        case .dynamic(let style, let isDetail, let screenSize):
            return provider.makeFont(style, fontName: configuration.getFontName(isDetail: isDetail), screenSize: screenSize)
        }
    }
    
    var resolvedLayout: NnTextLayout {
        return textLayout ?? configuration.textLayout
    }
}

public extension View {
    func withFont(_ style: Font.TextStyle = .body, isDetail: Bool = false, textColor: Color? = nil, layout: NnTextLayout? = nil) -> some View {
        modifier(
            CustomFontViewModifier(
                source: .dynamic(style: style, isDetail: isDetail, screenSize: .init(width: screenWidth, height: screenHeight)),
                textColor: textColor,
                textLayout: layout
            )
        )
    }
    
    func withFont(_ style: Font.TextStyle = .body, fontName: String, textColor: Color? = nil, layout: NnTextLayout? = nil) -> some View {
        modifier(
            CustomFontViewModifier(
                source: .fontName(style: style, fontName: fontName, screenSize: .init(width: screenWidth, height: screenHeight)),
                textColor: textColor,
                textLayout: layout
            )
        )
    }
}
