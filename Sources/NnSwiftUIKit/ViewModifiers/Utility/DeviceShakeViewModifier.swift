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

public extension View {
    /// Adds a shake gesture listener that performs an action when the device is shaken.
    ///
    /// This modifier conditionally attaches an `.onReceive` listener to observe the
    /// `UIDevice.deviceDidShakeNotification`. Because SwiftUI rebuilds views when modifier
    /// chains differ, toggling `isActive` can cause view reinitialization or loss of state
    /// for any view that manages its own source of truth.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own state**, or to keep the modifier always applied and
    /// internally control behavior using the `isActive` flag within the action.
    ///
    /// When active, the modifier listens for system shake events and executes the provided action.
    ///
    /// - Parameters:
    ///   - isActive: A Boolean controlling whether shake detection is active.
    ///   - action: The closure executed when the device shake is detected.
    /// - Returns: A modified view that responds to device shake events when active.
    func onDeviceShake(isActive: Bool, action: @escaping () -> Void) -> some View {
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
