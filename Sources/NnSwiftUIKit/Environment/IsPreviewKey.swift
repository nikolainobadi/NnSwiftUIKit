//
//  IsPreviewKey.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

/// A key that indicates whether the current environment is in preview mode.
public struct IsPreviewKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    /// A Boolean value that indicates whether the current environment is in preview mode.
    var isPreview: Bool {
        get { self[IsPreviewKey.self] }
        set { self[IsPreviewKey.self] = newValue }
    }
}

