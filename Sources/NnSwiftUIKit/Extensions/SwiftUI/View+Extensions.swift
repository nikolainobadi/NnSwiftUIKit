//
//  View+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

public extension View {
    var screenWidth: CGFloat {
        #if canImport(UIKit)
        return UIScreen.main.bounds.size.width
        #elseif canImport(AppKit)
        return NSScreen.main?.frame.size.width ?? 0
        #endif
    }
    
    var screenHeight: CGFloat {
        #if canImport(UIKit)
        return UIScreen.main.bounds.size.height
        #elseif canImport(AppKit)
        return NSScreen.main?.frame.size.height ?? 0
        #endif
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func nnGetWidthPercent(_ percent: CGFloat) -> CGFloat {
        return screenWidth * (percent * 0.01)
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func nnGetHeightPercent(_ percent: CGFloat) -> CGFloat {
        return screenHeight * (percent * 0.01)
    }
}
