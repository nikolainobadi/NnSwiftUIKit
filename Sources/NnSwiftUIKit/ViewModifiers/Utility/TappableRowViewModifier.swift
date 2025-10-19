//
//  TappableRowViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

struct TappableRowViewModifier: ViewModifier {
    @EnvironmentObject private var context: NnErrorHandlingContext
    
    let tint: Color
    let tapIsActive: Bool
    let withChevron: Bool
    let maxWidth: CGFloat
    let alignment: Alignment
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        if tapIsActive {
            content
                .asRowItem(withChevron: withChevron, maxWidth: maxWidth, alignment: alignment, tint: tint)
                .onTapGesture {
                    context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
                }
        } else {
            content
                .asRowItem(withChevron: withChevron, maxWidth: maxWidth, alignment: alignment, tint: tint)
        }
    }
}

public extension View {
    /// Configures the view as a tappable row item with customizable layout, chevron display, and async tap handling.
    ///
    /// This modifier conditionally applies gesture and layout modifiers based on `tapIsActive`.
    /// Because SwiftUI reconstructs views when modifier chains differ, toggling `tapIsActive`
    /// can lead to unexpected reinitialization or state loss in views that own local state or bindings.
    ///
    /// It is recommended to use this modifier **only on stateless or display-only views**
    /// that **do not manage their own source of truth**. For stateful views, prefer keeping
    /// the same modifier chain and disabling user interaction conditionally inside the action.
    ///
    /// When active, the row responds to tap gestures and executes the provided async action via
    /// the shared `NnErrorHandlingContext`, which automatically manages loading and error display.
    /// The modifier also allows customization of layout, alignment, tint, and chevron visibility.
    ///
    /// - Parameters:
    ///   - tapIsActive: A Boolean controlling whether the tap gesture is active. Defaults to `true`.
    ///   - withChevron: A Boolean indicating if a chevron should appear on the right. Defaults to `false`.
    ///   - maxWidth: The maximum width of the row. Defaults to `.infinity`.
    ///   - tint: The color used for the chevron and accent. Defaults to `.primary`.
    ///   - alignment: The content alignment within the row. Defaults to `.leading`.
    ///   - hideLoadingIndicator: Whether async actions should hide the loading overlay. Defaults to `false`.
    ///   - onTapGesture: The asynchronous action to perform when the row is tapped.
    /// - Returns: A modified view styled as a tappable row with async tap support and error handling.
    func tappable(
        tapIsActive: Bool = true,
        withChevron: Bool = false,
        maxWidth: CGFloat = .infinity,
        tint: Color = .primary,
        alignment: Alignment = .leading,
        hideLoadingIndicator: Bool = false,
        onTapGesture: @escaping () async throws -> Void
    ) -> some View {
        modifier(
            TappableRowViewModifier(
                tint: tint,
                tapIsActive: tapIsActive,
                withChevron: withChevron,
                maxWidth: maxWidth,
                alignment: alignment,
                hideLoadingIndicator: hideLoadingIndicator,
                action: onTapGesture
            )
        )
    }
}
