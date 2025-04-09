//
//  AccessibleLabelInfo.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 4/9/25.
//

public struct AccessibleLabelInfo {
    public let text: String
    public let systemImage: String
    public let accessibilityId: String?
    
    public init(text: String, systemImage: String, accessibilityId: String? = nil) {
        self.text = text
        self.systemImage = systemImage
        self.accessibilityId = accessibilityId
    }
}
