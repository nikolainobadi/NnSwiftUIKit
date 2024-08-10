//
//  NnButtonRole.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// An enum representing the role of a button, either cancel or destructive.
public enum NnButtonRole {
    case cancel, destructive
    
    /// Converts NnButtonRole to SwiftUI's ButtonRole.
    @available(iOS 15.0, *)
    public var buttonRole: ButtonRole {
        switch self {
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}

/// An extension of ButtonRole to convert it to NnButtonRole.
@available(iOS 15.0, *)
public extension ButtonRole {
    /// Converts SwiftUI's ButtonRole to NnButtonRole.
    var nnButtonRole: NnButtonRole {
        switch self {
        case .destructive:
            return .destructive
        default:
            return .cancel
        }
    }
}

