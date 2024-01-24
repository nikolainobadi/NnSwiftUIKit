//
//  RowItemViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

struct RowItemViewModifier: ViewModifier {
    let withChevron: Bool
    
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: .infinity)
            
            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .contentShape(Rectangle())
    }
}

public extension View {
    func nnAsRowItem(withChevron: Bool = false) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron))
    }
}
