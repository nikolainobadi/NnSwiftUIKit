//
//  FontConfiguration.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 10/19/25.
//

import SwiftUI

/// Configuration for default font appearance throughout the view hierarchy.
///
/// This struct allows you to set default values for text color and font names
/// that will be used by font modifiers unless explicitly overridden.
public struct FontConfiguration: Sendable {
    /// The default text color for font modifiers.
    public var textColor: Color

    public var textLayout: NnTextLayout
    
    /// The default font name used for detail text (when `isDetail: true`).
    public var detailFontName: String

    /// The default font name used for non-detail text (when `isDetail: false`).
    public var nonDetailFontName: String

    /// Creates a new font configuration.
    /// - Parameters:
    ///   - textColor: The default text color. Defaults to `.primary`.
    ///   - detailFontName: The font name for detail text. Defaults to `"HelveticaNeue"`.
    ///   - nonDetailFontName: The font name for non-detail text. Defaults to `"HelveticaNeue-Bold"`.
    public init(
        textColor: Color = .primary,
        textLayout: NnTextLayout = .unlimited,
        detailFontName: String = "HelveticaNeue",
        nonDetailFontName: String = "HelveticaNeue-Bold"
    ) {
        self.textColor = textColor
        self.textLayout = textLayout
        self.detailFontName = detailFontName
        self.nonDetailFontName = nonDetailFontName
        
    }
}

extension FontConfiguration {
    func getFontName(isDetail: Bool) -> String {
        return isDetail ? detailFontName : nonDetailFontName
    }
}
