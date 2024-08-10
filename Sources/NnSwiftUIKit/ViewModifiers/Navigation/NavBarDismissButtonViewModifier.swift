//
//  NavBarDismissButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//
import SwiftUI

public enum NavBarDismissType {
    case xmark, cancel, done
}


@available(iOS 15.0, *)
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
            .nnWithNavBarButton(placement: placement ?? dismissType.defaultPlacement, buttonContent: buttonContent, textColor: textColor, isActive: isActive, accessibilityId: accessibilityId) {
                if let action = action {
                    action()
                } else {
                    dismiss()
                }
            }
    }
}


// MARK: - Extension Dependencies
extension NavBarDismissType {
    var defaultPlacement: ToolbarItemPlacement? {
        #if canImport(UIKit)
        return self == .done ? .topBarTrailing : .topBarLeading
        #else
        return .automatic
        #endif
    }
}
