//
//  PanGestureViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 8/10/24.
//

#if canImport(UIKit)
import SwiftUI

/// A view modifier that handles vertical pan gestures in a SwiftUI view, triggering actions based on swipe direction.
public enum PanGestureSwipeDirection {
    case up, down
}

/// A view modifier that triggers actions based on the direction of a vertical pan gesture in a SwiftUI view.
struct PanGestureViewModifier: ViewModifier {
    /// A closure that handles the swipe direction detected from the pan gesture.
    let handleSwipeDirection: (PanGestureSwipeDirection) -> Void
    
    /// Handles the pan gesture and determines the swipe direction.
    /// - Parameter gesture: The pan gesture recognizer.
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            if -(velocityY / 5) > 60 {
                handleSwipeDirection(.up)
            }
        } else {
            if (velocityY / 5) > 40 {
                handleSwipeDirection(.down)
            }
        }
    }
    
    /// Modifies the content view to trigger actions based on the direction of a vertical pan gesture.
    func body(content: Content) -> some View {
        content
            .background(
                CustomGesture { handleGesture($0) }
            )
    }
}

// MARK: - Custom Gesture

fileprivate struct CustomGesture: UIViewRepresentable {
    /// A unique identifier for the gesture.
    private let gestureId = UUID().uuidString
    
    /// A closure that handles changes in the pan gesture.
    var onChange: (UIPanGestureRecognizer) -> Void
    
    /// Makes the coordinator for the gesture.
    func makeCoordinator() -> Coordinator {
        return .init(onChange: onChange)
    }
    
    /// Creates an empty `UIView` to attach the gesture to.
    func makeUIView(context: Context) -> some UIView {
        return .init()
    }
    
    /// Updates the view with the gesture recognizer.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let superview = uiView.superview?.superview,
               !(superview.gestureRecognizers?.contains(where: { $0.name == gestureId }) ?? false) {
                let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.gestureChange(gesture:)))
                
                gesture.name = gestureId
                gesture.delegate = context.coordinator
                
                superview.addGestureRecognizer(gesture)
            }
        }
    }
    
    /// A coordinator class that handles gesture recognizer delegate methods.
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onChange: (UIPanGestureRecognizer) -> Void
        
        init(onChange: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onChange = onChange
        }
        
        @objc func gestureChange(gesture: UIPanGestureRecognizer) {
            onChange(gesture)
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
}
#endif
