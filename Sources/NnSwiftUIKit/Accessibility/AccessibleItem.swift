//
//  AccessibleItem.swift
//
//
//  Created by Nikolai Nobadi on 8/7/24.
//

public struct AccessibleItem {
    public let prompt: String
    public let accessibilityId: String?
    
    public init(prompt: String, accessibilityId: String? = nil) {
        self.prompt = prompt
        self.accessibilityId = accessibilityId
    }
}
