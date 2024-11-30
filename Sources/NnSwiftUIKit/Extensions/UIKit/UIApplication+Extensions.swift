//
//  UIApplication+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

#if canImport(UIKit)
import UIKit

/// Extension for UIApplication to provide additional utility methods.
public extension UIApplication {
    /// Retrieves the top-most view controller in the current window hierarchy.
    /// - Returns: The top-most `UIViewController` if available.
    func getTopViewController() -> UIViewController? {
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController
    }
}
#endif
