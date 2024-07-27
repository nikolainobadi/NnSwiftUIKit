//
//  UIAlertController+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

#if canImport(UIKit)
import UIKit

@MainActor
public extension UIAlertController {
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
