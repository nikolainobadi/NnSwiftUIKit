//
//  NnAppVersionCache.swift
//  
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import Foundation

public enum NnAppVersionCache {
    public static func getDeviceVersionDetails(mainBundle: Bundle, includeBuildInDebug: Bool = true) -> String {
        guard let versionNumber = mainBundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        
        let versionString = "Version \(versionNumber)"
        
        #if DEBUG
        guard includeBuildInDebug, let buildNumber = mainBundle.infoDictionary?["CFBundleVersion"] as? String else {
            return versionString
        }
        
        return "\(versionString), Build: \(buildNumber)"
        #else
        return versionString
        #endif
    }
}
