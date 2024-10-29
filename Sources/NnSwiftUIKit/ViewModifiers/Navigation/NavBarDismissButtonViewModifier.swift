//
//  NavBarDismissButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//
import SwiftUI

/// A view modifier that adds a dismiss button to the navigation bar with customizable appearance and behavior.
struct NavBarDismissButtonViewModifier: ViewModifier {
    /// The dismiss action provided by the SwiftUI environment.
    @Environment(\.dismiss) private var dismiss
    
    /// A boolean value indicating whether the dismiss button is active.
    let isActive: Bool
    
    /// The placement of the dismiss button in the navigation bar.
    let placement: ToolbarItemPlacement?
    
    /// The color of the dismiss button text or image.
    let textColor: Color
    
    /// The type of dismiss button (e.g., "xmark", "cancel", "done").
    let dismissType: NavBarDismissType
    
    /// The accessibility identifier for the dismiss button.
    let accessibilityId: String?
    
    /// An optional action to be performed when the dismiss button is tapped.
    let action: (() -> Void)?
    
    /// The content of the dismiss button (either text or image).
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
    
    /// Modifies the content view to add a dismiss button to the navigation bar.
    func body(content: Content) -> some View {
        content
            .nnWithNavBarButton(placement: placement ?? dismissType.defaultPlacement, buttonContent: buttonContent, textColor: textColor, isActive: isActive, accessibilityId: accessibilityId) {
                if let action = action {
                    action()
                } else {
                    dismiss()
                }
            }
    }
}

public extension View {
    func nnWithNavBarDismissButton(isActive: Bool = true, placement: ToolbarItemPlacement? = nil, textColor: Color = .white, dismissType: NavBarDismissType = .xmark, accessibilityId: String? = nil, dismiss: (() -> Void)? = nil) -> some View {
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
