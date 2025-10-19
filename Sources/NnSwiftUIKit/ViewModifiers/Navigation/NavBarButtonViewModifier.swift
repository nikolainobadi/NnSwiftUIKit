//
//  NavBarButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct NavBarButtonViewModifier: ViewModifier {
    let placement: ToolbarItemPlacement
    let buttonContent: NavBarButtonContent
    let accessibilityId: String?
    let font: Font
    let textColor: Color
    let isActive: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    if isActive {
                        AsyncTryButton(action: action) {
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
                        .setOptionalAccessibiltyId(accessibilityId)
                    }
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
    ///   - action: The action to perform when the button is tapped.
    /// - Returns: A modified view with the navigation bar button.
    func withNavBarButton(placement: ToolbarItemPlacement? = nil, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, isActive: Bool = true, accessibilityId: String? = nil, action: @escaping () async throws -> Void) -> some View {
        modifier(NavBarButtonViewModifier(placement: placement ?? .automatic, buttonContent: buttonContent, accessibilityId: accessibilityId, font: font, textColor: textColor, isActive: isActive, action: action))
    }
}


// MARK: - Dependencies
/// An enum representing the content of a navigation bar button (either text or image).
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
