//
//  TabEndDropZone.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/10/26.
//

#if os(macOS)
import SwiftUI
import UniformTypeIdentifiers

/// A trailing drop target for reorderable tab bars.
///
/// Place after a `ForEach` of `reorderableTab(id:draggingTabId:onReorder:)` rows
/// to let users drop a dragged tab into the last position. Shows an insertion
/// cursor when a drag is hovering over the zone.
///
/// **macOS only.**
public struct TabEndDropZone: View {
    @State private var isTargeted: Bool = false

    private let height: CGFloat
    private let indicatorColor: Color
    private let indicatorWidth: CGFloat
    private let indicatorHeight: CGFloat
    private let indicatorCornerRadius: CGFloat
    private let indicatorLeadingPadding: CGFloat
    private let dropAnimation: Animation
    private let onDropToEnd: @MainActor (UUID) -> Void

    /// Creates a trailing drop zone for tab reordering.
    /// - Parameters:
    ///   - height: The maximum height of the drop zone. Defaults to `28`.
    ///   - indicatorColor: Fill color of the insertion cursor shown when a drag hovers. Defaults to `.accentColor`.
    ///   - indicatorWidth: Width of the insertion cursor. Defaults to `2`.
    ///   - indicatorHeight: Height of the insertion cursor. Defaults to `20`.
    ///   - indicatorCornerRadius: Corner radius of the insertion cursor. Defaults to `2`.
    ///   - indicatorLeadingPadding: Leading padding applied to the insertion cursor. Defaults to `2`.
    ///   - dropAnimation: Animation used when the dropped tab settles. Defaults to `.snappy`.
    ///   - onDropToEnd: Called with the dropped tab's `UUID` when a drag finishes inside the zone.
    public init(
        height: CGFloat = 28,
        indicatorColor: Color = .accentColor,
        indicatorWidth: CGFloat = 2,
        indicatorHeight: CGFloat = 20,
        indicatorCornerRadius: CGFloat = 2,
        indicatorLeadingPadding: CGFloat = 2,
        dropAnimation: Animation = .snappy,
        onDropToEnd: @escaping @MainActor (UUID) -> Void
    ) {
        self.height = height
        self.indicatorColor = indicatorColor
        self.indicatorWidth = indicatorWidth
        self.indicatorHeight = indicatorHeight
        self.indicatorCornerRadius = indicatorCornerRadius
        self.indicatorLeadingPadding = indicatorLeadingPadding
        self.dropAnimation = dropAnimation
        self.onDropToEnd = onDropToEnd
    }

    public var body: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: height)
            .contentShape(.rect)
            .layoutPriority(-1)
            .overlay(alignment: .leading) {
                if isTargeted {
                    RoundedRectangle(cornerRadius: indicatorCornerRadius)
                        .fill(indicatorColor)
                        .frame(width: indicatorWidth, height: indicatorHeight)
                        .padding(.leading, indicatorLeadingPadding)
                }
            }
            .onDrop(of: [.text], isTargeted: $isTargeted) { providers in
                handleDrop(providers: providers)
            }
    }
}

// MARK: - Private Methods
private extension TabEndDropZone {
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        guard let provider = providers.first else {
            return false
        }

        provider.loadObject(ofClass: NSString.self) { object, _ in
            guard
                let nsString = object as? NSString,
                let droppedId = UUID(uuidString: nsString as String)
            else {
                return
            }

            Task { @MainActor in
                withAnimation(dropAnimation) {
                    onDropToEnd(droppedId)
                }
            }
        }

        return true
    }
}
#endif
