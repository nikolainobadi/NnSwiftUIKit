//
//  TappableRowViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a tappable row item with customizable appearance and behavior.
struct TappableRowViewModifier: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let tapIsActive: Bool
    let withChevron: Bool
    let tint: Color
    let alignment: Alignment
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .asRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
            .showingConditionalView(when: tapIsActive) {
                content
                    .asRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
                    .onTapGesture {
                        Task {
                            loadingHandler.startLoading()
                            
                            do {
                                try await action()
                            } catch {
                                errorHandler.handle(error: error)
                            }
                            
                            loadingHandler.stopLoading()
                        }
                    }
            }
    }
}

public extension View {
    /// Configures the view as a tappable row item with customizable appearance and behavior.
    /// - Parameters:
    ///   - tapIsActive: A Boolean indicating whether the tap action is active.
    ///   - withChevron: A Boolean indicating if a chevron should be displayed on the right.
    ///   - tint: The tint color for the chevron, defaulting to primary.
    ///   - alignment: The alignment of the content within the row item, defaulting to leading.
    ///   - onTapGesture: The action to perform when the row is tapped.
    /// - Returns: A modified view configured as a tappable row item.
    func tappable(tapIsActive: Bool = true, withChevron: Bool = false, tint: Color = .primary, alignment: Alignment = .leading, onTapGesture: @escaping () async throws -> Void) -> some View {
        modifier(TappableRowViewModifier(tapIsActive: tapIsActive, withChevron: withChevron, tint: tint, alignment: alignment, action: onTapGesture))
    }
}
