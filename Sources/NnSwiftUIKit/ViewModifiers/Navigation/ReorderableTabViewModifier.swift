//
//  ReorderableTabViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/10/26.
//

#if os(macOS)
import SwiftUI
import UniformTypeIdentifiers

struct ReorderableTabViewModifier: ViewModifier {
    @Binding var draggingTabId: UUID?

    let tabId: UUID
    let reorderAnimation: Animation
    let onReorder: (UUID, UUID) -> Void

    func body(content: Content) -> some View {
        content
            .onDrag {
                draggingTabId = tabId
                let provider = NSItemProvider()
                provider.registerObject(tabId.uuidString as NSString, visibility: .ownProcess)
                return provider
            }
            .onDrop(of: [.text], delegate: TabDropDelegate(
                draggingTabId: $draggingTabId,
                tabId: tabId,
                reorderAnimation: reorderAnimation,
                onReorder: onReorder
            ))
    }
}

// MARK: - Drop Delegate
private struct TabDropDelegate: DropDelegate {
    @Binding var draggingTabId: UUID?
    
    let tabId: UUID
    let reorderAnimation: Animation
    let onReorder: (UUID, UUID) -> Void

    // Live reorder: as the dragged tab crosses a neighbor, swap immediately so
    // SwiftUI animates the move during the drag rather than only on release.
    func dropEntered(info: DropInfo) {
        if let dragged = draggingTabId, dragged != tabId {
            withAnimation(reorderAnimation) {
                onReorder(dragged, tabId)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return .init(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        draggingTabId = nil
        return true
    }
}

public extension View {
    /// Makes this view draggable and reorderable within a tab bar.
    ///
    /// Attach to each tab row inside a `ForEach`. As the dragged tab crosses a
    /// neighbor, `onReorder` fires so the caller can swap the underlying model
    /// and SwiftUI animates the move during the drag.
    ///
    /// **macOS only.**
    ///
    /// - Parameters:
    ///   - id: The unique identifier of this tab.
    ///   - draggingTabId: A shared binding that tracks which tab is currently being dragged. Pass the same binding to every reorderable tab in the bar.
    ///   - reorderAnimation: Animation used when neighbors swap during a drag. Defaults to `.snappy`.
    ///   - onReorder: Called with the dragged tab's id and the target tab's id whenever the drag crosses a neighbor.
    /// - Returns: A view that participates in tab drag-and-drop reordering.
    func reorderableTab(
        id: UUID,
        draggingTabId: Binding<UUID?>,
        reorderAnimation: Animation = .snappy,
        onReorder: @escaping (_ draggedId: UUID, _ targetId: UUID) -> Void
    ) -> some View {
        modifier(
            ReorderableTabViewModifier(
                draggingTabId: draggingTabId,
                tabId: id,
                reorderAnimation: reorderAnimation,
                onReorder: onReorder
            )
        )
    }
}
#endif
