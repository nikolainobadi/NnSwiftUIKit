//
//  AccessibleItemInfo.swift
//
//
//  Created by Nikolai Nobadi on 8/7/24.
//

public struct AccessibleItemInfo {
    public let prompt: String
    public let accessibilityId: String?
    
    public init(prompt: String, accessibilityId: String? = nil) {
        self.prompt = prompt
        self.accessibilityId = accessibilityId
    }
}
