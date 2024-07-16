//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 7/14/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomSwipeActionViewModifier: ViewModifier {
    let title: String
    let image: String
    let edge: HorizontalEdge
    let tint: Color
    let isActive: Bool
    let action: () -> Void

    
    func body(content: Content) -> some View {
        if isActive {
            content
                .swipeActions(edge: edge) {
                    
                    Button(action: action) {
                        if image.isEmpty {
                            Text(title)
                        } else {
                            Label(title, systemImage: image)
                        }
                    }
                    .tint(tint)
                }
        } else {
            content
        }
    }
}
