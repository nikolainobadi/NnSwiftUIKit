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
    let font: Font
    let textColor: Color
    let action: () -> Void
    
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
                }
            }
    }
}

public extension View {
    func nnWithNavBarButton(placement: ToolbarItemPlacement = .navigationBarTrailing, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, action: @escaping () -> Void) -> some View {
        modifier(NavBarButtonViewModifier(placement: placement, buttonContent: buttonContent, font: font, textColor: textColor, action: action))
    }
}


// MARK: - Dependencies
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
