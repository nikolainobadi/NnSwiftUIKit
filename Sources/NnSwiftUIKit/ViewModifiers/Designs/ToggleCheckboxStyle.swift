//
//  ToggleCheckboxStyle.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 11/23/25.
//

import SwiftUI

public struct ToggleCheckboxStyle: ToggleStyle {
    let tint: Color
    let onImage: Image.ImageType
    let offImage: Image.ImageType
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Button(action: { configuration.isOn.toggle() }) {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .tint(tint)
            }
        }
    }
}

public extension ToggleStyle where Self == ToggleCheckboxStyle {
    static func checkboxToggleStyle(
        tint: Color = .green,
        onImage: Image.ImageType = .system("checkmark.square"),
        offImage: Image.ImageType = .system("square")
    ) -> ToggleCheckboxStyle {
        return .init(tint: tint, onImage: onImage, offImage: offImage)
    }
}

