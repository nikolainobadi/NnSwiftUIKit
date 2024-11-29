//
//  AsyncNavBarButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 11/29/24.
//

import SwiftUI

struct AsyncNavBarButtonViewModifier: ViewModifier {
    // The placement of the navigation bar button.
    let placement: ToolbarItemPlacement
    
    /// The content of the navigation bar button (text or image).
    let buttonContent: NavBarButtonContent
    
    /// The accessibility identifier for the button.
    let accessibilityId: String?
    
    /// The font of the button text or image.
    let font: Font
    
    /// The color of the button text or image.
    let textColor: Color
    
    /// A boolean value indicating whether the button is active.
    let isActive: Bool
    
    /// The action to be performed when the button is tapped.
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    NnAsyncTryButton(action: action) {
                        switch buttonContent {
                        case .image(let imageType):
                            Image(imageType: imageType)
                                .font(font)
                                .foregroundColor(textColor)
                        case .text(let buttonText):
                            Text(buttonText)
                                .font(font)
                                .foregroundColor(textColor)
                        }
                    }
                    .nnSetAccessibiltyId(accessibilityId)
                    .nnOnlyShow(when: isActive)
                }
            }
    }
}

public extension View {
    /// Adds a navigation bar button with customizable appearance and behavior.
    /// - Parameters:
    ///   - placement: The placement of the button within the navigation bar.
    ///   - buttonContent: The content of the button, either text or image.
    ///   - font: The font of the button text or image, defaulting to title2.
    ///   - textColor: The color of the button text or image, defaulting to primary.
    ///   - isActive: A Boolean indicating whether the button is active, defaulting to true.
    ///   - accessibilityId: The accessibility identifier for the button.
    ///   - action: The async try action to perform when the button is tapped.
    /// - Returns: A modified view with the navigation bar button.
    func nnWithAsyncNavBarButton(placement: ToolbarItemPlacement? = nil, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, isActive: Bool = true, accessibilityId: String? = nil, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncNavBarButtonViewModifier(placement: placement ?? .automatic, buttonContent: buttonContent, accessibilityId: accessibilityId, font: font, textColor: textColor, isActive: isActive, action: action))
    }
}
