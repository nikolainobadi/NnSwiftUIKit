//
//  NavStack.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// A custom navigation stack for iOS 16+, with support for setting a title and custom display mode.
public struct NavStack<Content: View>: View {
    /// The navigation path binding that controls the navigation stack.
    @Binding var path: NavigationPath
    
    /// The optional title for the navigation bar.
    let title: String?
    
    /// The content view to be displayed within the navigation stack.
    let content: () -> Content
    
    #if canImport(UIKit)
    /// The display mode for the navigation bar title.
    let displayMode: NavigationBarItem.TitleDisplayMode
    
    /// Initializes a `NavStack` with a binding path, title, display mode, and content.
    public init(path: Binding<NavigationPath>? = nil, title: String?, displayMode: NavigationBarItem.TitleDisplayMode = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self._path = path ?? .constant(.init())
        self.title = title
        self.displayMode = displayMode
        self.content = content
    }
    #else
    /// Initializes a `NavStack` with a binding path, title, and content (for platforms other than UIKit).
    public init(path: Binding<NavigationPath>? = nil, title: String?, @ViewBuilder content: @escaping () -> Content) {
        self._path = path ?? .constant(.init())
        self.title = title
        self.content = content
    }
    #endif
    
    public var body: some View {
        NavigationStack(path: $path) {
            content()
                .withNavTitle(title: title)
            #if canImport(UIKit)
                .navigationBarTitleDisplayMode(displayMode)
            #endif
        }
    }
}

/// A custom navigation stack with support for custom data paths for iOS 16+.
public struct CustomPathNavStack<Data, Content: View>: View where Data: MutableCollection, Data: RandomAccessCollection, Data: RangeReplaceableCollection, Data.Element: Hashable {
    /// The custom data path binding that controls the navigation stack.
    @Binding var path: Data
    
    /// The optional title for the navigation bar.
    let title: String?
    
    /// The content view to be displayed within the navigation stack.
    let content: () -> Content
    
    #if canImport(UIKit)
    /// The display mode for the navigation bar title.
    let displayMode: NavigationBarItem.TitleDisplayMode
    
    /// Initializes a `CustomPathNavStack` with a binding data path, title, display mode, and content.
    public init(path: Binding<Data>, title: String?, displayMode: NavigationBarItem.TitleDisplayMode = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self._path = path
        self.title = title
        self.displayMode = displayMode
        self.content = content
    }
    #else
    /// Initializes a `CustomPathNavStack` with a binding data path, title, and content (for platforms other than UIKit).
    public init(path: Binding<Data>, title: String?, @ViewBuilder content: @escaping () -> Content) {
        self._path = path
        self.title = title
        self.content = content
    }
    #endif
    
    public var body: some View {
        NavigationStack(path: $path) {
            content()
                .withNavTitle(title: title)
            #if canImport(UIKit)
                .navigationBarTitleDisplayMode(displayMode)
            #endif
        }
    }
}
