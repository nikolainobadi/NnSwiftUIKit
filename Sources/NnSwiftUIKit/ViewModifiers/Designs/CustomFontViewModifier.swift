//
//  CustomFontViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that applies a custom font to a SwiftUI view with optional text color, auto-sizing, and minimum scale factor.
struct CustomFontViewModifier: ViewModifier {
    /// The font to be applied to the view.
    let font: Font
    
    /// The color of the text.
    let textColor: Color
    
    /// A boolean value indicating whether the text should auto-size to fit its container.
    let autoSize: Bool
    
    /// The minimum scale factor for the text when auto-sizing is enabled.
    let minimumScaleFactor: CGFloat
    
    /// Modifies the content view to apply the custom font, text color, and other settings.
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(textColor)
            .minimumScaleFactor(autoSize ? minimumScaleFactor : 1)
    }
}

public extension View {
    func withFont(_ style: Font.TextStyle = .body, isDetail: Bool = false, textColor: Color = .primary, autoSizeLineLimit lineLimit: Int? = nil, minimumScaleFactor: CGFloat = 0.5, detailFont: String? = nil, nonDetailFont: String? = nil) -> some View {
        self.lineLimit(lineLimit)
            .setCustomFont(style, fontName: isDetail ? (detailFont ?? "HelveticaNeue") : (nonDetailFont ?? "HelveticaNeue-Bold"), textColor: textColor, autoSize: lineLimit != nil, minimumScaleFactor: minimumScaleFactor)
    }
    
    /// Applies a custom font with optional text color, auto-sizing, and minimum scale factor.
    /// - Parameters:
    ///   - style: The text style for the font.
    ///   - fontName: The name of the custom font.
    ///   - textColor: The color of the text, defaulting to primary.
    ///   - autoSize: A Boolean indicating whether the text should auto-size to fit the container.
    ///   - minimumScaleFactor: The minimum scale factor when auto-sizing is enabled, defaulting to 0.5.
    /// - Returns: A modified view with the specified custom font and attributes.
    func setCustomFont(_ style: Font.TextStyle, fontName: String, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: makeFont(style, fontName: fontName), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    /// Applies a custom font with specified font name and size.
    /// - Parameters:
    ///   - fontName: The name of the custom font.
    ///   - size: The font size.
    ///   - textColor: The color of the text, defaulting to primary.
    ///   - autoSize: A Boolean indicating whether the text should auto-size to fit the container.
    ///   - minimumScaleFactor: The minimum scale factor when auto-sizing is enabled, defaulting to 0.5.
    /// - Returns: A modified view with the specified font size and attributes.
    func setCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: Font.custom(fontName, size: size), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
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
