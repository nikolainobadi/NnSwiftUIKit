//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct TappableRowViewModifier: ViewModifier {
    let withChevron: Bool
    let onTapGesture: () -> Void
    
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: .infinity)
            
            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTapGesture)
    }
}

public extension View {
    func tappable(withChevron: Bool = false, onTapGesture: @escaping () -> Void) -> some View {
        modifier(TappableRowViewModifier(withChevron: withChevron, onTapGesture: onTapGesture))
    }
}