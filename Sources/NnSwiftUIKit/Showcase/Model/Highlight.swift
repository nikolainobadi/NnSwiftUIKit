//
//  Highlight.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

import SwiftUI

/// A struct representing a highlighted area with specific attributes.
struct Highlight: Identifiable, Equatable {
    /// The unique identifier for the highlight.
    var id: UUID = .init()
    
    /// The anchor representing the rectangle of the highlighted area.
    var anchor: Anchor<CGRect>
    
    /// The title associated with the highlight.
    var title: String
    
    /// The corner radius of the highlighted area.
    var cornerRadius: CGFloat
    
    /// The style of the rounded corners.
    var style: RoundedCornerStyle = .continuous
    
    /// The scale factor of the highlighted area.
    var scale: CGFloat = 1
}

/// A preference key for storing highlights associated with a view.
struct HighlightAnchorKey: PreferenceKey {
    /// The default value for the preference key, an empty dictionary.
    static var defaultValue: [Int: Highlight] = [:]
    
    /// Reduces the value by merging the next value with the existing one.
    static func reduce(value: inout [Int: Highlight], nextValue: () -> [Int: Highlight]) {
        return value.merge(nextValue()) { $1 }
    }
}
