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
    /// Applies a custom font using environment-configured font names with dynamic sizing based on screen dimensions.
    ///
    /// This modifier uses the `FontSizeProvider` to calculate appropriate font sizes and selects the font name
    /// from `FontConfiguration` based on the `isDetail` parameter. All values fall back to environment defaults
    /// when not explicitly specified.
    ///
    /// - Parameters:
    ///   - style: The text style to use for size calculation (e.g., `.headline`, `.body`, `.caption`). Defaults to `.body`.
    ///   - isDetail: If `true`, uses the detail font name from configuration; if `false`, uses the non-detail font name. Defaults to `false`.
    ///   - textColor: The color to apply to the text. If `nil`, uses the environment's `FontConfiguration.textColor`. Defaults to `nil`.
    ///   - layout: The text layout strategy (unlimited, multiline, or single-line auto-sizing). If `nil`, uses the environment's `FontConfiguration.textLayout`. Defaults to `nil`.
    /// - Returns: A modified view with the custom font, color, and layout applied.
    func withFont(_ style: Font.TextStyle = .body, isDetail: Bool = false, textColor: Color? = nil, layout: NnTextLayout? = nil) -> some View {
        modifier(
            CustomFontViewModifier(
                source: .dynamic(style: style, isDetail: isDetail, screenSize: .init(width: screenWidth, height: screenHeight)),
                textColor: textColor,
                textLayout: layout
            )
        )
    }

    /// Applies a custom font using an explicit font name with dynamic sizing based on screen dimensions.
    ///
    /// This modifier uses the `FontSizeProvider` to calculate appropriate font sizes for the specified font name,
    /// overriding the environment's configured font names. Use this when you need a specific font that differs
    /// from the environment defaults.
    ///
    /// - Parameters:
    ///   - style: The text style to use for size calculation (e.g., `.headline`, `.body`, `.caption`). Defaults to `.body`.
    ///   - fontName: The name of the font to use (e.g., "Helvetica-Bold", "CustomFont"). This overrides the environment's font configuration.
    ///   - textColor: The color to apply to the text. If `nil`, uses the environment's `FontConfiguration.textColor`. Defaults to `nil`.
    ///   - layout: The text layout strategy (unlimited, multiline, or single-line auto-sizing). If `nil`, uses the environment's `FontConfiguration.textLayout`. Defaults to `nil`.
    /// - Returns: A modified view with the custom font, color, and layout applied.
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
