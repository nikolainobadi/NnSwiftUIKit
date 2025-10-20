//
//  NavBarButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

struct NavBarButtonViewModifier: ViewModifier {
    @Environment(\.navBarTextColor) private var environmentTextColor

    let placement: ToolbarItemPlacement
    let buttonContent: NavBarButtonContent
    let accessibilityId: String?
    let fontStyle: Font.TextStyle
    let textColor: Color?
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
                                    .withFont(fontStyle, textColor: textColor ?? environmentTextColor)
                            case .text(let buttonText):
                                Text(buttonText)
                                    .withFont(fontStyle, textColor: textColor ?? environmentTextColor)
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
    ///   - fontStyle: The font style of the button text or image, defaulting to body.
    ///   - textColor: The color of the button text or image. If `nil`, uses the environment's `navBarTextColor` value. Defaults to `nil`.
    ///   - isActive: A Boolean indicating whether the button is active, defaulting to true.
    ///   - accessibilityId: The accessibility identifier for the button.
    ///   - action: The action to perform when the button is tapped.
    /// - Returns: A modified view with the navigation bar button.
    func withNavBarButton(
        placement: ToolbarItemPlacement? = nil,
        buttonContent: NavBarButtonContent,
        fontStyle: Font.TextStyle = .body,
        textColor: Color? = nil,
        isActive: Bool = true,
        accessibilityId: String? = nil,
        action: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            NavBarButtonViewModifier(
                placement: placement ?? .automatic,
                buttonContent: buttonContent,
                accessibilityId: accessibilityId,
                fontStyle: fontStyle,
                textColor: textColor,
                isActive: isActive,
                action: action
            )
        )
    }
}


// MARK: - Dependencies
/// An enum representing the content of a navigation bar button (either text or image).
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
