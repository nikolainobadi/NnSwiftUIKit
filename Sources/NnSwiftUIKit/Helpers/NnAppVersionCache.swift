//
//  NnAppVersionCache.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import Foundation

public enum NnAppVersionCache {
    public enum BuildNumberDisplay {
        case never
        case debugOnly
        case always
    }
    
    /// Retrieves the app version details from the provided bundle, optionally including the build number based on the specified display option.
    ///
    /// - Parameters:
    ///   - mainBundle: The `Bundle` instance containing the app's version and build information.
    ///   - buildNumberDisplay: The display option for the build number. Defaults to `.debugOnly`.
    /// - Returns: A string representing the app's version, optionally including the build number.
    public static func getDeviceVersionDetails(mainBundle: Bundle, buildNumberDisplay: BuildNumberDisplay = .debugOnly) -> String {
        guard let versionNumber = mainBundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        
        let versionString = "Version \(versionNumber)"
        
        guard let buildNumber = mainBundle.infoDictionary?["CFBundleVersion"] as? String else {
            return versionString
        }
        
        switch buildNumberDisplay {
        case .never:
            return versionString
        case .always:
            return "\(versionString), Build: \(buildNumber)"
        case .debugOnly:
#if DEBUG
            return "\(versionString), Build: \(buildNumber)"
#else
            return versionString
#endif
        }
    }
    
    @available(*, deprecated, message: "Use getDeviceVersionDetails(mainBundle:buildNumberDisplay:) instead.")
    public static func getDeviceVersionDetails(mainBundle: Bundle, includeBuildInDebug: Bool = true) -> String {
        return getDeviceVersionDetails(mainBundle: mainBundle, buildNumberDisplay: includeBuildInDebug ? .debugOnly : .never)
    }
}
