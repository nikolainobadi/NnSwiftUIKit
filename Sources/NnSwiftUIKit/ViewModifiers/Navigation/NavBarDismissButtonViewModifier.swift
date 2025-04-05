//
//  NavBarDismissButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//
import SwiftUI

/// A view modifier that adds a dismiss button to the navigation bar with customizable appearance and behavior.
struct NavBarDismissButtonViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    let isActive: Bool
    let placement: ToolbarItemPlacement?
    let textColor: Color
    let dismissType: NavBarDismissType
    let accessibilityId: String?
    let action: (() -> Void)?
    
    private var buttonContent: NavBarButtonContent {
        switch dismissType {
        case .xmark:
            return .image(.system("xmark"))
        case .cancel:
            return .text("Cancel")
        case .done:
            return .text("Done")
        }
    }
    
    func body(content: Content) -> some View {
        content
            .withNavBarButton(placement: placement ?? dismissType.defaultPlacement, buttonContent: buttonContent, textColor: textColor, isActive: isActive, accessibilityId: accessibilityId) {
                if let action = action {
                    action()
                } else {
                    dismiss()
                }
            }
    }
}

public extension View {
    /// Adds a dismiss button to the navigation bar with customizable appearance and behavior.
    /// - Parameters:
    ///   - isActive: A Boolean indicating whether the dismiss button is active, defaulting to true.
    ///   - placement: The placement of the dismiss button in the navigation bar.
    ///   - textColor: The color of the dismiss button text or image, defaulting to white.
    ///   - dismissType: The type of dismiss button (e.g., "xmark", "cancel", "done").
    ///   - accessibilityId: The accessibility identifier for the dismiss button.
    ///   - dismiss: An optional action to perform when the dismiss button is tapped.
    /// - Returns: A modified view with a dismiss button in the navigation bar.
    func withNavBarDismissButton(isActive: Bool = true, placement: ToolbarItemPlacement? = nil, textColor: Color = .white, dismissType: NavBarDismissType = .xmark, accessibilityId: String? = nil, dismiss: (() -> Void)? = nil) -> some View {
        modifier(NavBarDismissButtonViewModifier(isActive: isActive, placement: placement, textColor: textColor, dismissType: dismissType, accessibilityId: accessibilityId, action: dismiss))
    }
}

/// An enum representing the type of dismiss button (e.g., "xmark", "cancel", "done").
public enum NavBarDismissType {
    case xmark, cancel, done
}

// MARK: - Extension Dependencies
extension NavBarDismissType {
    /// The default placement of the dismiss button in the navigation bar, based on the dismiss type.
    var defaultPlacement: ToolbarItemPlacement? {
        #if canImport(UIKit)
        return self == .done ? .topBarTrailing : .topBarLeading
        #else
        return .automatic
        #endif
    }
}
