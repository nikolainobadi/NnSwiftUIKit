//
//  TappableRowViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

/// A view modifier that configures a SwiftUI view as a tappable row item with customizable appearance and behavior.
struct TappableRowViewModifier: ViewModifier {
    @EnvironmentObject var context: NnErrorHandlingContext
    
    let tint: Color
    let tapIsActive: Bool
    let withChevron: Bool
    let maxWidth: CGFloat
    let alignment: Alignment
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .asRowItem(withChevron: withChevron, maxWidth: maxWidth, alignment: alignment, tint: tint)
            .modifier(TapModifier(isActive: tapIsActive, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}

public extension View {
    /// Configures the view as a tappable row item with customizable appearance and behavior.
    ///
    /// - Parameters:
    ///   - tapIsActive: A Boolean indicating whether the tap action is active.
    ///   - withChevron: A Boolean indicating if a chevron should be displayed on the right.
    ///   - maxWidth: The maximum width the view can occupy. Defaults to `.infinity`.
    ///   - tint: The tint color for the chevron, defaulting to primary.
    ///   - alignment: The alignment of the content within the row item, defaulting to leading.
    ///   - hideLoadingIndicator: A Boolean indicating whther or not async methods should include a loading indicator. Defaults to `false`.
    ///   - onTapGesture: The action to perform when the row is tapped.
    func tappable(tapIsActive: Bool = true, withChevron: Bool = false, maxWidth: CGFloat = .infinity, tint: Color = .primary, alignment: Alignment = .leading, hideLoadingIndicator: Bool = false, onTapGesture: @escaping () async throws -> Void) -> some View {
        modifier(TappableRowViewModifier(tint: tint, tapIsActive: tapIsActive, withChevron: withChevron, maxWidth: maxWidth, alignment: alignment, hideLoadingIndicator: hideLoadingIndicator, action: onTapGesture))
    }
}


// MARK: - Helpers
private struct TapModifier: ViewModifier {
    @EnvironmentObject var context: NnErrorHandlingContext
    
    let isActive: Bool
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void

    func body(content: Content) -> some View {
        content
            .showingConditionalView(when: isActive) {
                content
                    .onTapGesture {
                        context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
                    }
            }
    }
}
