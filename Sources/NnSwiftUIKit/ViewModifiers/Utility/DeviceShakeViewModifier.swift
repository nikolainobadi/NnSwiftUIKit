//
//  DeviceShakeViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 7/3/24.
//

#if canImport(UIKit)
import SwiftUI

/// A view modifier that triggers an action when the device is shaken in a SwiftUI view.
struct DeviceShakeViewModifier: ViewModifier {
    /// A boolean value indicating whether the shake action is active.
    let isActive: Bool
    
    /// The action to perform when the device is shaken.
    let action: () -> Void
    
    /// Modifies the content view to trigger an action when the device is shaken.
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

public extension View {
    func nnOnShake(isActive: Bool, action: @escaping () -> Void) -> some View {
        modifier(DeviceShakeViewModifier(isActive: isActive, action: action))
    }
}

// MARK: - Extension Dependencies
extension UIDevice {
    /// A notification that is posted when the device is shaken.
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    /// Overrides the motionEnded function to post a shake notification when the device is shaken.
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}
#endif
