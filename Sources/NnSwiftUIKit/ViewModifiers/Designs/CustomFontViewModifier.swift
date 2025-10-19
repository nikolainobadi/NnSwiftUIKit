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
            .minimumScaleFactor(autoSize ? minimumScaleFactor : 1)
    }
}

public extension View {
    /// Applies a custom font, color, and optional automatic text scaling to the view’s text content.
    ///
    /// This modifier provides fine-grained control over text appearance while maintaining
    /// flexibility for responsive layouts. It supports separate fonts for “detail” and
    /// “non-detail” text, along with automatic scaling behavior when a line limit is set.
    ///
    /// Because this modifier adjusts the view’s appearance dynamically, it is best used
    /// on **stateless or text-based views**. Applying it conditionally to views that own
    /// local state can cause SwiftUI to rebuild their hierarchy when modifier chains differ,
    /// potentially leading to state loss or reinitialization. To avoid that, keep modifier
    /// chains consistent and vary only the parameters.
    ///
    /// - Parameters:
    ///   - style: The base `Font.TextStyle` to use (e.g., `.body`, `.headline`). Defaults to `.body`.
    ///   - isDetail: A Boolean that determines whether to use the detail font or non-detail font. Defaults to `false`.
    ///   - textColor: The color applied to the text. Defaults to `.primary`.
    ///   - autoSizeLineLimit: The maximum number of lines to display. When non-nil, enables automatic scaling.
    ///   - minimumScaleFactor: The minimum scale factor applied when auto-sizing text. Defaults to `0.5`.
    ///   - detailFont: An optional custom font name for detail text. Defaults to `"HelveticaNeue"`.
    ///   - nonDetailFont: An optional custom font name for non-detail text. Defaults to `"HelveticaNeue-Bold"`.
    ///
    /// - Returns: A modified view styled with the given font, color, and optional scaling behavior.
    func withFont(
        _ style: Font.TextStyle = .body,
        isDetail: Bool = false,
        textColor: Color = .primary,
        autoSizeLineLimit lineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 0.5,
        detailFont: String? = nil,
        nonDetailFont: String? = nil
    ) -> some View {
        self
            .lineLimit(lineLimit)
            .setCustomFont(
                style,
                fontName: isDetail ? (detailFont ?? "HelveticaNeue") : (nonDetailFont ?? "HelveticaNeue-Bold"),
                textColor: textColor,
                autoSize: lineLimit != nil,
                minimumScaleFactor: minimumScaleFactor
            )
    }
    
    /// Applies a custom font with optional text color, auto-sizing, and minimum scale factor.
    /// - Parameters:
    ///   - style: The text style for the font.
    ///   - fontName: The name of the custom font.
    ///   - textColor: The color of the text, defaulting to primary.
    ///   - autoSize: A Boolean indicating whether the text should auto-size to fit the container.
    ///   - minimumScaleFactor: The minimum scale factor when auto-sizing is enabled, defaulting to 0.5.
    /// - Returns: A modified view with the specified custom font and attributes.
    func setCustomFont(
        _ style: Font.TextStyle,
        fontName: String,
        textColor: Color = .primary,
        autoSize: Bool = false,
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        modifier(
            CustomFontViewModifier(
                font: makeFont(style, fontName: fontName),
                textColor: textColor,
                autoSize: autoSize,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }
    
    /// Applies a custom font with specified font name and size.
    /// - Parameters:
    ///   - fontName: The name of the custom font.
    ///   - size: The font size.
    ///   - textColor: The color of the text, defaulting to primary.
    ///   - autoSize: A Boolean indicating whether the text should auto-size to fit the container.
    ///   - minimumScaleFactor: The minimum scale factor when auto-sizing is enabled, defaulting to 0.5.
    /// - Returns: A modified view with the specified font size and attributes.
    func setCustomFont(
        fontName: String,
        size: CGFloat,
        textColor: Color = .primary,
        autoSize: Bool = false,
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        modifier(
            CustomFontViewModifier(
                font: Font.custom(fontName, size: size),
                textColor: textColor,
                autoSize: autoSize,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }
}


// MARK: - Helpers
internal extension View {
    /// Creates a custom font with a specific style and font name.
    /// - Parameters:
    ///   - style: The text style for the font.
    ///   - fontName: The name of the custom font.
    /// - Returns: A custom `Font` object.
    func makeFont(_ style: Font.TextStyle, fontName: String) -> Font {
        return Font.custom(fontName, size: makeFontSize(style))
    }
    
    /// Determines the appropriate font size for a given text style.
    /// - Parameter style: The text style for which to determine the font size.
    /// - Returns: The font size as a `CGFloat`.
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
