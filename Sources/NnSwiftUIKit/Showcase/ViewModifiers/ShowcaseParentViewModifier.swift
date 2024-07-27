//
//  ShowcaseParentViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 2/27/24.
//

#if canImport(UIKit)
import SwiftUI

@available(iOS 16.4, *)
struct ShowcaseParentViewModifier: ViewModifier {
    @Namespace private var animation
    @State private var showView = true
    @State private var showTitle = false
    @State private var currentHighlight: Int = 0
    @State private var highlightOrder: [Int] = []
    
    let showHighlights: Bool
    let onFinished: () -> Void
    
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
    var shouldShowcaseSubviews: Bool {
        return highlightOrder.indices.contains(currentHighlight) && showHighlights && showView
    }
    
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
                    print("should be showing title")
                }
            }
        }
    }
}


// MARK: - Dependencies
@available(iOS 16.4, *)
struct HighlightedView: View {
    @Binding var showingTitle: Bool
    @Namespace var animation
    
    let highlight: Highlight
    let highlightRect: CGRect
    let safeArea: EdgeInsets
    
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
