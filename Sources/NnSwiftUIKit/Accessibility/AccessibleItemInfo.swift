//
//  AccessibleItemInfo.swift
//
//
//  Created by Nikolai Nobadi on 8/7/24.
//

/// A struct representing accessibility information for an item.
public struct AccessibleItemInfo {
    public let prompt: String
    public let accessibilityId: String?
    
    /// Initializes an `AccessibleItemInfo` with a prompt and an optional accessibility identifier.
    /// - Parameters:
    ///   - prompt: The prompt text for the item.
    ///   - accessibilityId: The accessibility identifier for the item. Default is nil.
    public init(prompt: String, accessibilityId: String? = nil) {
        self.prompt = prompt
        self.accessibilityId = accessibilityId
    }
}
