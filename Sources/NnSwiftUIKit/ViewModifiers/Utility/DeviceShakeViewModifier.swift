//
//  DeviceShakeViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/3/24.
//

#if canImport(UIKit)
import SwiftUI

struct DeviceShakeViewModifier: ViewModifier {
    let isActive: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        if isActive {
            content
                .onAppear()
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                    action()
                }
        } else {
            content
        }
    }
}


// MARK: - Extension Dependencies
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}
#endif
