//
//  AsyncTryButton.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A SwiftUI view that represents a button performing an asynchronous action with error handling.
public struct AsyncTryButton<Label: View>: View {
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let role: ButtonRole?
    let label: () -> Label
    let hideLoadingIndicator: Bool
    let hapticFeedback: HapticFeedback?
    let action: () async throws -> Void
    
    public init(action: @escaping () async throws -> Void, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, hapticFeedback: HapticFeedback? = nil, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
        self.role = role
        self.hideLoadingIndicator = hideLoadingIndicator
        self.hapticFeedback = hapticFeedback
    }
    
    public var body: some View {
        Button(role: role, action: performAction, label: label)
    }
}


// MARK: - Initializers
public extension AsyncTryButton where Label == Text {
    /// Convenience initializer for a button with a text label.
    init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, hapticFeedback: HapticFeedback? = nil, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, hideLoadingIndicator: hideLoadingIndicator, hapticFeedback: hapticFeedback, label: { Text(titleKey) })
    }
    
    /// Convenience initializer for a button with a string label.
    init<S>(_ title: S, role: ButtonRole? = nil, hideLoadingIndicator: Bool = false, hapticFeedback: HapticFeedback? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, hideLoadingIndicator: hideLoadingIndicator, hapticFeedback: hapticFeedback, label: { Text(title) })
    }
}

// MARK: - Haptics
public extension AsyncTryButton {
    enum HapticFeedback {
        case selection
        case impact(style: ImpactStyle)
        case notification(type: NotificationType)
    }
    
    enum ImpactStyle {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }
    
    enum NotificationType {
        case success
        case warning
        case error
    }
}

// MARK: - Private Methods
private extension AsyncTryButton {
    /// Performs the action associated with the button and handles loading and errors.
    func performAction() {
        triggerHaptics()
        context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
    }
    
    func triggerHaptics() {
        guard let hapticFeedback else { return }
        
        #if os(iOS)
        switch hapticFeedback {
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style.uiKitStyle)
            generator.prepare()
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type.uiKitType)
        }
        #endif
    }
}

#if os(iOS)
private extension AsyncTryButton.ImpactStyle {
    var uiKitStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light:
            return .light
        case .medium:
            return .medium
        case .heavy:
            return .heavy
        case .soft:
            return .soft
        case .rigid:
            return .rigid
        }
    }
}

private extension AsyncTryButton.NotificationType {
    var uiKitType: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
        case .success:
            return .success
        case .warning:
            return .warning
        case .error:
            return .error
        }
    }
}
#endif
