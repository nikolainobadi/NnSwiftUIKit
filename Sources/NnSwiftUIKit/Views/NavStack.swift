//
//  NavStack.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct NavStack<Content: View>: View {
    @Binding var path: NavigationPath
    
    let title: String?
    let displayMode: NavigationBarItem.TitleDisplayMode
    let content: () -> Content
    
    public init(path: Binding<NavigationPath>? = nil, title: String?, displayMode: NavigationBarItem.TitleDisplayMode = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self._path = path ?? .constant(.init())
        self.title = title
        self.displayMode = displayMode
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            content()
                .withNavTitle(title: title)
                .navigationBarTitleDisplayMode(displayMode)
        }
    }
}

@available(iOS 16.0, *)
public struct CustomPathNavStack<Data, Content: View>: View where Data: MutableCollection, Data: RandomAccessCollection, Data: RangeReplaceableCollection, Data.Element: Hashable {
    @Binding var path: Data
    
    let title: String?
    let displayMode: NavigationBarItem.TitleDisplayMode
    let content: () -> Content
    
    public init(path: Binding<Data>, title: String?, displayMode: NavigationBarItem.TitleDisplayMode = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self._path = path
        self.title = title
        self.displayMode = displayMode
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            content()
                .withNavTitle(title: title)
                .navigationBarTitleDisplayMode(displayMode)
        }
    }
}
