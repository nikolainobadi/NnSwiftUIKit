//
//  NnAppVersionCache.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import Foundation

public enum NnAppVersionCache {
    /// Retrieves the app version details from the provided bundle, optionally including the build number in debug mode.
    ///
    /// - Parameters:
    ///   - mainBundle: The `Bundle` instance containing the app's version and build information.
    ///   - includeBuildInDebug: A Boolean indicating whether the build number should be included in debug mode. Defaults to `true`.
    /// - Returns: A string representing the app's version. If running in debug mode and `includeBuildInDebug` is true, the string includes the build number.
    ///
    /// - Note: The function checks the `CFBundleShortVersionString` and `CFBundleVersion` keys in the bundle's info dictionary.
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
