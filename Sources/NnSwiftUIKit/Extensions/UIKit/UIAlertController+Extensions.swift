//
//  UIAlertController+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

#if canImport(UIKit)
import UIKit

/// Extension for UIAlertController to provide additional utility methods.
@MainActor
public extension UIAlertController {
    /// Presents the alert controller on the top-most view controller in the app.
    /// - Parameters:
    ///   - animated: A boolean indicating whether the presentation should be animated. Default is true.
    ///   - completion: An optional closure to be executed after the presentation finishes.
    func presentInMainThread(animated: Bool = true, completion: (() -> Void)? = nil) {
        if var topController = UIApplication.shared.getTopViewController() {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(self, animated: animated, completion: completion)
        }
    }
}
#endif
