//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct TappableRowViewModifier: ViewModifier {
    let tapIsActive: Bool
    let withChevron: Bool
    let onTapGesture: () -> Void
    
    func body(content: Content) -> some View {
        if tapIsActive {
            content
                .nnAsRowItem(withChevron: withChevron)
                .onTapGesture(perform: onTapGesture)
        } else {
            content
                .nnAsRowItem(withChevron: withChevron)
        }
    }
}
