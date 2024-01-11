//
//  NavStack.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

@available(iOS 16.0, *)
struct NavStack<Content: View>: View {
    var path: Binding<NavigationPath>?
    
    let title: String?
    let content: () -> Content
    
    var body: some View {
        if let pathBinding = path {
            NavigationStack(path: pathBinding) {
                if let title = title {
                    content()
                        .navigationTitle(title)
                } else {
                    content()
                }
            }
        } else {
            NavigationStack {
                if let title = title {
                    content()
                        .navigationTitle(title)
                } else {
                    content()
                }
            }
        }
    }
}
