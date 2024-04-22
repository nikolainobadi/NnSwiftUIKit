//
//  RowItemViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/16/24.
//

import SwiftUI

struct RowItemViewModifier: ViewModifier {
    let withChevron: Bool
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: .infinity, alignment: alignment)
            
            if withChevron {
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .contentShape(Rectangle())
    }
}
