//
//  CustomFontViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    @Environment(\.fontSizeProvider) private var provider
    @Environment(\.fontConfiguration) private var configuration

    let source: Source
    let textColor: Color?
    let lineLimit: Int?
    let minimumScaleFactor: CGFloat

    enum Source: Sendable {
        case explicit(Font)
        case dynamic(style: Font.TextStyle, fontName: String?, isDetail: Bool, screenSize: CGSize)
    }
    
    private var resolvedTextColor: Color {
        return textColor ?? configuration.textColor
    }

    private var font: Font {
        switch source {
        case .explicit(let font):
            return font
        case .dynamic(let style, let fontName, let isDetail, let screenSize):
            let resolvedFontName = fontName ?? (isDetail ? configuration.detailFontName : configuration.nonDetailFontName)
            return provider.makeFont(style, fontName: resolvedFontName, screenSize: screenSize)
        }
    }

    func body(content: Content) -> some View {
        if let lineLimit = lineLimit {
            content
                .font(font)
                .foregroundStyle(resolvedTextColor)
                .lineLimit(lineLimit)
                .minimumScaleFactor(minimumScaleFactor)
        } else {
            content
                .font(font)
                .foregroundStyle(resolvedTextColor)
        }
    }
}

public extension View {
    func withFont(
        _ style: Font.TextStyle = .body,
        isDetail: Bool = false,
        textColor: Color? = nil,
        autoSizeLineLimit lineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 0.5,
        detailFont: String? = nil,
        nonDetailFont: String? = nil,
        screenSize: CGSize? = nil
    ) -> some View {
        modifier(
            CustomFontModifier(
                source: .dynamic(
                    style: style,
                    fontName: isDetail ? detailFont : nonDetailFont,
                    isDetail: isDetail,
                    screenSize: screenSize ?? CGSize(width: screenWidth, height: screenHeight)
                ),
                textColor: textColor,
                lineLimit: lineLimit,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }

    func setCustomFont(
        _ style: Font.TextStyle,
        fontName: String? = nil,
        isDetail: Bool = false,
        textColor: Color? = nil,
        autoSizeLineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 0.5,
        screenSize: CGSize? = nil
    ) -> some View {
        modifier(
            CustomFontModifier(
                source: .dynamic(
                    style: style,
                    fontName: fontName,
                    isDetail: isDetail,
                    screenSize: screenSize ?? CGSize(width: screenWidth, height: screenHeight)
                ),
                textColor: textColor,
                lineLimit: autoSizeLineLimit,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }

    @available(*, deprecated, renamed: "setCustomFont(_:fontName:isDetail:textColor:autoSizeLineLimit:minimumScaleFactor:screenSize:)", message: "Use autoSizeLineLimit parameter instead for more flexibility in line count")
    func setCustomFont(
        _ style: Font.TextStyle,
        fontName: String,
        textColor: Color = .primary,
        autoSize: Bool = false,
        minimumScaleFactor: CGFloat = 0.5,
        screenSize: CGSize? = nil
    ) -> some View {
        setCustomFont(
            style,
            fontName: fontName,
            isDetail: false,
            textColor: textColor,
            autoSizeLineLimit: autoSize ? 1 : nil,
            minimumScaleFactor: minimumScaleFactor,
            screenSize: screenSize
        )
    }

    func setCustomFont(
        fontName: String,
        size: CGFloat,
        textColor: Color? = nil,
        autoSizeLineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        modifier(
            CustomFontModifier(
                source: .explicit(Font.custom(fontName, size: size)),
                textColor: textColor,
                lineLimit: autoSizeLineLimit,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }

    @available(*, deprecated, renamed: "setCustomFont(fontName:size:textColor:autoSizeLineLimit:minimumScaleFactor:)", message: "Use autoSizeLineLimit parameter instead for more flexibility in line count")
    func setCustomFont(
        fontName: String,
        size: CGFloat,
        textColor: Color = .primary,
        autoSize: Bool = false,
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        setCustomFont(
            fontName: fontName,
            size: size,
            textColor: textColor,
            autoSizeLineLimit: autoSize ? 1 : nil,
            minimumScaleFactor: minimumScaleFactor
        )
    }
}
