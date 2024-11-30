//
//  NavBarButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A view modifier that adds a navigation bar button to a SwiftUI view with customizable appearance and behavior.
struct NavBarButtonViewModifier: ViewModifier {
    /// The placement of the navigation bar button.
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
    let action: () -> Void
    
    /// Modifies the content view to add a navigation bar button with the specified settings.
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    Button(action: action) {
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
                    .setAccessibiltyId(accessibilityId)
                    .onlyShow(when: isActive)
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
    func withNavBarButton(placement: ToolbarItemPlacement? = nil, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, isActive: Bool = true, accessibilityId: String? = nil, action: @escaping () -> Void) -> some View {
        modifier(NavBarButtonViewModifier(placement: placement ?? .automatic, buttonContent: buttonContent, accessibilityId: accessibilityId, font: font, textColor: textColor, isActive: isActive, action: action))
    }
}


// MARK: - Dependencies
/// An enum representing the content of a navigation bar button (either text or image).
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
