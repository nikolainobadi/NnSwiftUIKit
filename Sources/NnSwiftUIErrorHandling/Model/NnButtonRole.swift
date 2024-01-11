//
//  NnButtonRole.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

public enum NnButtonRole {
    case cancel, destructive
    
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

@available(iOS 15.0, *)
public extension ButtonRole {
    var nnButtonRole: NnButtonRole {
        switch self {
        case .destructive:
            return .destructive
        default:
            return .cancel
        }
    }
}
