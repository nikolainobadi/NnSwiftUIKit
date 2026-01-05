//
//  View+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

#if !os(WatchOS)
import SwiftUI

public extension View {
    var screenWidth: CGFloat {
        #if os(iOS)
        UIScreen.main.bounds.size.width
        #elseif os(macOS)
        NSScreen.main?.frame.size.width ?? 0
        #elseif os(watchOS)
        WKInterfaceDevice.current().screenBounds.size.width
        #else
        0
        #endif
    }

    var screenHeight: CGFloat {
        #if os(iOS)
        UIScreen.main.bounds.size.height
        #elseif os(macOS)
        NSScreen.main?.frame.size.height ?? 0
        #elseif os(watchOS)
        WKInterfaceDevice.current().screenBounds.size.height
        #else
        0
        #endif
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func getWidthPercent(_ percent: CGFloat) -> CGFloat {
        return screenWidth * (percent * 0.01)
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func getHeightPercent(_ percent: CGFloat) -> CGFloat {
        return screenHeight * (percent * 0.01)
    }
}
#endif
