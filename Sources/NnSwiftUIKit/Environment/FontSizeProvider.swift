//
//  FontSizeProvider.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/25.
//

import SwiftUI

/// A protocol that provides font sizing logic based on screen dimensions.
///
/// Conforming types can implement custom font size calculations for different text styles
/// and screen sizes. The default implementation uses percentage-based calculations.
public protocol FontSizeProvider: Sendable {
    /// Creates a custom font with the specified style and font name.
    /// - Parameters:
    ///   - style: The text style for the font.
    ///   - fontName: The name of the custom font.
    ///   - screenSize: The size of the screen or container.
    /// - Returns: A custom `Font` object.
    func makeFont(_ style: Font.TextStyle, fontName: String, screenSize: CGSize) -> Font

    /// Calculates the appropriate font size for a given text style.
    /// - Parameters:
    ///   - style: The text style for which to determine the font size.
    ///   - screenSize: The size of the screen or container.
    /// - Returns: The font size as a `CGFloat`.
    func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat
}

// MARK: - Default Implementation
public extension FontSizeProvider {
    func makeFont(_ style: Font.TextStyle, fontName: String, screenSize: CGSize) -> Font {
        return Font.custom(fontName, size: makeFontSize(style, screenSize: screenSize))
    }
}

// MARK: - Default Provider
/// Default implementation of `FontSizeProvider` using percentage-based calculations.
///
/// This provider calculates font sizes as a percentage of the screen height,
/// providing consistent scaling across different device sizes.
public struct DefaultFontSizeProvider: FontSizeProvider {
    public init() {}

    public func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat {
        let percent: CGFloat

        switch style {
        case .largeTitle:
            percent = 7
        case .title:
            percent = 6
        case .title2:
            percent = 4.8
        case .title3:
            percent = 4
        case .headline:
            percent = 3.5
        case .subheadline:
            percent = 3
        case .body:
            percent = 2.5
        case .caption:
            percent = 2
        case .caption2:
            percent = 1.8
        default:
            return 8
        }

        return screenSize.height * (percent * 0.01)
    }
}
