//
//  String+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import Foundation

/// Extension for String to provide additional utility methods.
public extension String {
    /// Appends a string after skipping a line.
    /// - Parameter text: The text to append after a line break.
    /// - Returns: A new string with the appended text after two line breaks.
    func nnSkipLine(_ text: String) -> String {
        return "\(self)\n\n\(text)"
    }
    
    /// Removes extra whitespace from the string, including leading, trailing, and multiple consecutive spaces.
    /// - Returns: A new string with the extra whitespace removed.
    func nnRemovingExtraWhitespace() -> String {
        return self.split(separator: " ")
            .filter { !$0.isEmpty }
            .joined(separator: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

