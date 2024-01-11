//
//  ConditionalNavTitleViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct ConditionalNavTitleViewModifier: ViewModifier {
    let title: String?
    
    func body(content: Content) -> some View {
        if let title = title {
            content
                .navigationTitle(title)
        } else {
            content
        }
    }
}

public extension View {
    func withNavTitle(title: String?) -> some View {
        modifier(ConditionalNavTitleViewModifier(title: title))
    }
}
