//
//  NavBarDismissButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct NavBarDismissButtonViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    let dismissType: NavBarDismissType
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
            .withNavBarButton(placement: dismissType == .done ? .topBarTrailing : .topBarLeading, buttonContent: buttonContent, textColor: .white) {
                if let action = action {
                    action()
                } else {
                    dismiss()
                }
            }
    }
}

@available(iOS 15.0, *)
public extension View {
    func withNavBarDismissButton(dismissType: NavBarDismissType = .xmark, dismiss: (() -> Void)? = nil) -> some View {
        modifier(NavBarDismissButtonViewModifier(dismissType: dismissType, action: dismiss))
    }
}


// MARK: - Dependencies
public enum NavBarDismissType {
    case xmark, cancel, done
}