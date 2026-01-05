//
//  EmptyListViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/5/26.
//

import SwiftUI

struct EmptyListViewModifier: ViewModifier {
    let title: String
    let message: String
    let systemImage: String
    let listEmpty: Bool
    
    func body(content: Content) -> some View {
        if listEmpty {
            VStack {
                Image(systemName: systemImage)
                    .withFont(.title)
                
                Text(title)
                    .withFont(.title, autoSizeLineLimit: 1)
                
                Text(message)
                    .withFont(isDetail: true)
                    .multilineTextAlignment(.center)
            }
            .padding()
        } else {
            content
        }
    }
}

public extension View {
    func withEmptyListView(title: String, message: String, systemImage: String = "tray", listEmpty: Bool) -> some View {
        modifier(EmptyListViewModifier(title: title, message: message, systemImage: systemImage, listEmpty: listEmpty))
    }
}
