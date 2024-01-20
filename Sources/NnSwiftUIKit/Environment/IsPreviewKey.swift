//
//  IsPreviewKey.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

public struct IsPreviewKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isPreview: Bool {
        get { self[IsPreviewKey.self] }
        set { self[IsPreviewKey.self] = newValue }
    }
}
