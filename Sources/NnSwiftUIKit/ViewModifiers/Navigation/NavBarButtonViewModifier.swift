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
                    .nnSetAccessibiltyId(accessibilityId)
                    .nnOnlyShow(when: isActive)
                }
            }
    }
}

// MARK: - Dependencies
/// An enum representing the content of a navigation bar button (either text or image).
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
