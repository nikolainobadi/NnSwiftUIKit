//
//  String+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

public extension String {
    func nnSkipLine(_ text: String) -> String {
        return "\(self)\n\n\(text)"
    }
    
    func nnRemovingExtraWhitespace() -> String {
        return self.split(separator: " ")
            .filter { !$0.isEmpty }
            .joined(separator: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
