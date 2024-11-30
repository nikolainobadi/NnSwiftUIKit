//
//  ShowcaseParentViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

#if canImport(UIKit)
import SwiftUI

/// A view modifier that manages and displays a series of showcased views in sequence.
@available(iOS 16.4, *)
struct ShowcaseParentViewModifier: ViewModifier {
    /// A namespace for matched geometry effects.
    @Namespace private var animation
    
    /// A state variable that controls whether the showcase view is shown.
    @State private var showView = true
    
    /// A state variable that controls whether the showcase title is shown.
    @State private var showTitle = false
    
    /// A state variable that tracks the current highlighted view in the sequence.
    @State private var currentHighlight: Int = 0
    
    /// An array that stores the order of highlights.
    @State private var highlightOrder: [Int] = []
    
    /// A Boolean value indicating whether the highlights should be shown.
    let showHighlights: Bool
    
    /// A closure that is executed when the showcase sequence finishes.
    let onFinished: () -> Void
    
    /// Modifies the content view to manage and display showcased views in sequence.
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if shouldShowcaseSubviews {
                    if let highlight = preferences[highlightOrder[currentHighlight]] {
                        GeometryReader { proxy in
                            HighlightedView(
                                showingTitle: $showTitle,
                                animation: _animation,
                                highlight: highlight,
                                highlightRect: proxy[highlight.anchor],
                                safeArea: proxy.safeAreaInsets,
                                onTapGesture: showNextView
                            )
                            .nnDelayedOnAppear(seconds: 0.1) {
                                showTitle = true
                            }
                        }
                    }
                }
            }
    }
}

@available(iOS 16.4, *)
private extension ShowcaseParentViewModifier {
    /// Determines whether the showcase subviews should be displayed.
    var shouldShowcaseSubviews: Bool {
        return highlightOrder.indices.contains(currentHighlight) && showHighlights && showView
    }
    
    /// Advances to the next view in the showcase sequence.
    func showNextView() {
        if currentHighlight >= highlightOrder.count - 1 {
            withAnimation(.easeInOut(duration: 0.25)) {
                showView = false
                currentHighlight = 0
            }
            onFinished()
        } else {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                showTitle = false
                currentHighlight += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    showTitle = true
                }
            }
        }
    }
}

@available(iOS 16.4, *)
public extension View {
    func canShowcaseViews(showHighlights: Bool, onFinished: @escaping () -> Void) -> some View {
        modifier(ShowcaseParentViewModifier(showHighlights: showHighlights, onFinished: onFinished))
    }
}

// MARK: - Dependencies
/// A view representing a highlighted area with an optional title.
@available(iOS 16.4, *)
struct HighlightedView: View {
    /// A binding that controls whether the title is shown.
    @Binding var showingTitle: Bool
    
    /// The namespace for matched geometry effects.
    @Namespace var animation
    
    /// The highlight object containing details about the highlight.
    let highlight: Highlight
    
    /// The rectangle representing the highlight's position and size.
    let highlightRect: CGRect
    
    /// The safe area insets of the view.
    let safeArea: EdgeInsets
    
    /// A closure that is executed when the view is tapped.
    let onTapGesture: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(.black.opacity(0.5))
            .reverse {
                Rectangle()
                    .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
                    .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                    .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                    .scaleEffect(highlight.scale)
                    .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
            }
            .ignoresSafeArea()
            .onTapGesture(perform: onTapGesture)
        
        Rectangle()
            .foregroundStyle(.clear)
            .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
            .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
            .popover(isPresented: $showingTitle, content: {
                Text(highlight.title)
                    .padding(.horizontal, 10)
                    .presentationCompactAdaptation(.popover)
                    .interactiveDismissDisabled()
            })
            .scaleEffect(highlight.scale)
            .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
    }
}
#endif
