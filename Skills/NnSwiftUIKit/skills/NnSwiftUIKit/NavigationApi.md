# Navigation API

Navigation bar modifiers, tab item configuration, reorderable tabs (macOS), conditional view modifiers, gesture handlers, and custom input views.

---

## Enum: NavBarButtonContent

Content type for navigation bar buttons.

```swift
public enum NavBarButtonContent {
    case text(String)
    case image(Image.ImageType)
}
```

---

## Enum: NavBarDismissType

Dismiss button style for navigation bar.

```swift
public enum NavBarDismissType {
    case xmark   // SF Symbol xmark
    case cancel  // "Cancel" text
    case done    // "Done" text
}
```

Default placement (iOS): `.xmark` and `.cancel` -> `.topBarLeading`; `.done` -> `.topBarTrailing`.

---

## Enum: PanGestureSwipeDirection (iOS only)

Direction reported by the vertical pan gesture handler.

```swift
public enum PanGestureSwipeDirection {
    case up    // velocity threshold: > 300 pt/s upward
    case down  // velocity threshold: > 200 pt/s downward
}
```

**Note:** Upward swipe has a higher velocity threshold than downward.

---

## Enum: NnAppVersionCache

Utility for formatting app version strings.

```swift
public enum NnAppVersionCache
```

### Nested Types

**`BuildNumberDisplay`** — `case never`, `debugOnly`, `always`

### Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `getDeviceVersionDetails(mainBundle:buildNumberDisplay:)` | `String` | Returns formatted version string (e.g., "Version 1.2 (34)") |

The `.debugOnly` case uses `#if DEBUG` compile-time branching. Returns `""` if `CFBundleShortVersionString` is missing. Build number formatting is `"Version 1.2, Build: 34"`.

A second overload, `getDeviceVersionDetails(mainBundle:includeBuildInDebug:)`, is **deprecated** — it forwards to `buildNumberDisplay: includeBuildInDebug ? .debugOnly : .never`. Use the `buildNumberDisplay:` form.

### Usage Example

```swift
let version = NnAppVersionCache.getDeviceVersionDetails(
    mainBundle: .main,
    buildNumberDisplay: .debugOnly
)
// "Version 1.2.0" (release) or "Version 1.2.0 (42)" (debug)
```

---

## Struct: SliderStepperView\<SliderContent, StepperContent\>

Combined slider and stepper for integer value selection with customizable appearance.

```swift
public struct SliderStepperView<SliderContent: View, StepperContent: View>: View
```

### Initialization

| Initializer | Description |
|-------------|-------------|
| `init(value:range:spacing:alignment:stepperLabel:slider:stepper:)` | Full customization with transform closures |
| `init(value:range:)` | Simple default (where both content types are default). Label: "Adjust: \(value)" |

### Usage Example

```swift
// Simple
SliderStepperView(value: $minutes)

// Custom range
SliderStepperView(value: $minutes, range: .init(sliderStep: 10, stepperStep: 1, min: 0, max: 120))

// Full customization
SliderStepperView(
    value: $points,
    range: .init(sliderStep: 10, stepperStep: 1, min: 0, max: 100),
    spacing: 12,
    alignment: .leading,
    stepperLabel: { Text("Points: \($0)") },
    slider: { $0.tint(.orange) },
    stepper: { $0.foregroundStyle(.orange) }
)
```

---

## Struct: SliderStepperRange

Configuration for `SliderStepperView` range and step sizes.

```swift
public struct SliderStepperRange: Sendable {
    public let sliderStep: Int
    public let stepperStep: Int
    public let min: Int
    public let max: Int
    public init(sliderStep: Int = 5, stepperStep: Int = 5, min: Int = 5, max: Int = 60)
}
```

---

## Struct: OptionalStepper (iOS only)

Stepper that works with an optional `Int?` binding. When the binding is `nil`, the stepper displays at the range's lower bound. Setting the binding to `nil` externally does not reset the displayed value.

```swift
public struct OptionalStepper: View {
    public init(value: Binding<Int?>, range: ClosedRange<Int>, label: @escaping (Int) -> Text)
}
```

### Usage Example

```swift
OptionalStepper(value: $optionalCount, range: 1...10) { value in
    Text("Count: \(value)")
}
```

---

## Navigation Bar Modifiers

### `.withNavBarButton(placement:buttonContent:fontStyle:textColor:isActive:accessibilityId:action:)`

Async navigation bar button. Uses `AsyncTryButton` internally. Text color falls back to `\.navBarTextColor` environment when `nil`.

```swift
func withNavBarButton(
    placement: ToolbarItemPlacement? = nil,
    buttonContent: NavBarButtonContent,
    fontStyle: Font.TextStyle = .body,
    textColor: Color? = nil,
    isActive: Bool = true,
    accessibilityId: String? = nil,
    action: @escaping () async throws -> Void
) -> some View
```

### `.withNavBarDismissButton(isActive:placement:textColor:dismissType:accessibilityId:dismiss:)`

Navigation bar dismiss button. If a custom `dismiss` closure is provided, the environment `dismiss()` is NOT called — the caller handles dismissal.

```swift
func withNavBarDismissButton(
    isActive: Bool = true,
    placement: ToolbarItemPlacement? = nil,
    textColor: Color? = nil,
    dismissType: NavBarDismissType = .xmark,
    accessibilityId: String? = nil,
    dismiss: (() -> Void)? = nil
) -> some View
```

### `.activeOnChangeNavBarButton(item:fontStyle:textColor:accessibilityId:placement:buttonContent:action:)` — iOS only

Nav bar button that activates only when a tracked `Equatable` item changes. Once activated, **never resets** for the view's lifetime.

```swift
func activeOnChangeNavBarButton<Item: Equatable>(
    item: Item,
    fontStyle: Font.TextStyle = .body,
    textColor: Color? = nil,
    accessibilityId: String? = nil,
    placement: ToolbarItemPlacement? = nil,
    buttonContent: NavBarButtonContent,
    action: @escaping () async throws -> Void
) -> some View
```

### `.withCustomNavBarButton(placement:isActive:customView:)` — iOS only

Custom view in the navigation bar toolbar.

```swift
func withCustomNavBarButton<V: View>(
    placement: ToolbarItemPlacement = .topBarTrailing,
    isActive: Bool = true,
    @ViewBuilder customView: @escaping () -> V
) -> some View
```

---

## Discard Changes Modifiers (iOS only)

### `.withDiscardChangesNavBarDismissButton(_:message:itemToModify:placement:dismissType:dismissButtonInfo:)`

Auto-tracks changes by comparing `itemToModify` against a snapshot taken at initialization.

```swift
func withDiscardChangesNavBarDismissButton<Item: Equatable>(
    _ title: String? = nil,
    message: String? = nil,
    itemToModify: Item,
    placement: ToolbarItemPlacement? = nil,
    dismissType: NavBarDismissType? = nil,
    dismissButtonInfo: AccessibleItemInfo? = nil
) -> some View
```

### `.withDiscardChangesNavBarDismissButton(_:message:placement:didMakeChanges:dismissType:dismissButtonInfo:)`

Manual change tracking with a `Bool`.

```swift
func withDiscardChangesNavBarDismissButton(
    _ title: String? = nil,
    message: String? = nil,
    placement: ToolbarItemPlacement? = nil,
    didMakeChanges: Bool,
    dismissType: NavBarDismissType? = nil,
    dismissButtonInfo: AccessibleItemInfo? = nil
) -> some View
```

---

## Navigation Modifier Chain

```
.withDiscardChangesNavBarDismissButton(itemToModify:)
  +-- computes didMakeChanges = (itemToModify != originalItem)
      +-- .withDiscardChangesNavBarDismissButton(didMakeChanges:)
           +-- .withNavBarDismissButton(dismissType:)
                +-- .withNavBarButton(buttonContent:action:)
                     +-- AsyncTryButton + .withFont + .setOptionalAccessibiltyId
```

---

## Tab Bar

### Protocol: NnTabItem

Describes a tab in a `TabView`. Conform an enum or struct, then apply with `.asTabItem(_:)` for consistent tab configuration (label, tag, optional accessibility id).

```swift
public protocol NnTabItem {
    associatedtype Tag: Hashable
    var name: String { get }
    var imageName: String { get }   // SF Symbol name
    var tag: Tag { get }
    var accessibilityId: String? { get }   // default: nil
}
```

`accessibilityId` has a default implementation returning `nil`, so conformers only need to provide it when UI testing requires it.

### `.asTabItem(_:)`

Configures the view as a tab using an `NnTabItem`. Applies `Label(name, systemImage: imageName)` to `.tabItem`, attaches `tag` for selection binding, and applies the optional accessibility identifier.

```swift
func asTabItem<Item: NnTabItem>(_ item: Item) -> some View
```

#### Usage Example

```swift
enum AppTab: Int, NnTabItem {
    case home, library, settings

    var name: String {
        switch self {
        case .home: "Home"
        case .library: "Library"
        case .settings: "Settings"
        }
    }
    var imageName: String {
        switch self {
        case .home: "house"
        case .library: "books.vertical"
        case .settings: "gearshape"
        }
    }
    var tag: Int { rawValue }
}

TabView(selection: $selected) {
    HomeView().asTabItem(AppTab.home)
    LibraryView().asTabItem(AppTab.library)
    SettingsView().asTabItem(AppTab.settings)
}
```

### `.reorderableTab(id:draggingTabId:reorderAnimation:onReorder:)` — macOS only

Makes the view draggable and reorderable in a custom tab bar. As the dragged tab crosses a neighbor, `onReorder` fires so the caller can swap the underlying model. The drag is animated live during the gesture, not only on release. Pass the same `draggingTabId` binding to every reorderable tab in the bar.

```swift
func reorderableTab(
    id: UUID,
    draggingTabId: Binding<UUID?>,
    reorderAnimation: Animation = .snappy,
    onReorder: @escaping (_ draggedId: UUID, _ targetId: UUID) -> Void
) -> some View
```

**Note:** UUID-locked. Tab models must use `UUID` identifiers.

### Struct: TabEndDropZone — macOS only

Trailing drop target for reorderable tab bars. Place after a `ForEach` of `.reorderableTab(...)` rows to let users drop a tab into the last position. Shows a configurable insertion-cursor when a drag hovers.

```swift
public struct TabEndDropZone: View {
    public init(
        height: CGFloat = 28,
        indicatorColor: Color = .accentColor,
        indicatorWidth: CGFloat = 2,
        indicatorHeight: CGFloat = 20,
        indicatorCornerRadius: CGFloat = 2,
        indicatorLeadingPadding: CGFloat = 2,
        dropAnimation: Animation = .snappy,
        onDropToEnd: @escaping @MainActor (UUID) -> Void
    )
}
```

`onDropToEnd` is `@MainActor`-isolated — it's invoked inside `Task { @MainActor in ... }` after `NSItemProvider` resolves the payload.

#### Usage Example

```swift
#if os(macOS)
struct CustomTabBar: View {
    @Binding var tabs: [Tab]
    @State private var draggingTabId: UUID?

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                TabButton(tab: tab)
                    .reorderableTab(id: tab.id, draggingTabId: $draggingTabId) { draggedId, targetId in
                        reorder(draggedId, targetId)
                    }
            }
            TabEndDropZone { draggedId in
                moveToEnd(draggedId)
            }
        }
    }
}
#endif
```

---

## Conditional Modifiers

All use view-identity-changing branches (`if`/`else`). Content `@State` is reinitialized when the condition toggles.

### `.onlyShow(when:)`

Shows content only when condition is true. Content is removed from hierarchy when false.

```swift
func onlyShow(when conditional: Bool) -> some View
```

### `.showingConditionalView(when:conditionalView:)`

Replaces content with a conditional view when `isShowing` is true.

```swift
func showingConditionalView<V: View>(
    when isShowing: Bool,
    @ViewBuilder conditionalView: @escaping () -> V
) -> some View
```

### `.showingViewWithOptional(_:conditionalView:)`

Shows a view when an optional value is non-nil, passing the unwrapped value.

```swift
func showingViewWithOptional<I, V: View>(
    _ optional: I?,
    @ViewBuilder conditionalView: @escaping (I) -> V
) -> some View
```

### `.asNavLink(_:isActive:)`

Wraps content in a `NavigationLink` when `isActive` is true.

```swift
func asNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View
```

### `.withNavTitle(title:)`

Applies `.navigationTitle` when title is non-nil.

```swift
func withNavTitle(title: String?) -> some View
```

---

## Gesture Modifiers

### `.handlingVerticalPanGesture(handleSwipeDirection:)` — iOS only

Attaches a vertical pan gesture recognizer. The gesture recognizes simultaneously with other gestures.

```swift
func handlingVerticalPanGesture(
    handleSwipeDirection: @escaping (PanGestureSwipeDirection) -> Void
) -> some View
```

### `.onDeviceShake(isActive:action:)` — iOS only

Triggers action on device shake. **Warning:** The shake detection overrides `UIWindow.motionEnded` globally — it affects the entire app, not just the view it's applied to.

```swift
func onDeviceShake(isActive: Bool, action: @escaping () -> Void) -> some View
```

---

## Other Navigation Modifiers

### `.bindedNavigationDestination(itemList:destination:)`

Navigation destination with a binding to the item. If the item is removed from `itemList` during navigation, no destination view is rendered.

```swift
func bindedNavigationDestination<Item: Identifiable & Hashable, Destination: View>(
    itemList: Binding<[Item]>,
    destination: @escaping (Binding<Item>) -> Destination
) -> some View
```

### `.trackingItemChanges(item:itemDidChange:)` — iOS only

Tracks whether an `Equatable` item has changed from its initial value.

```swift
func trackingItemChanges<I: Equatable>(item: I, itemDidChange: Binding<Bool>) -> some View
```

### `.navBarTextColor(_:)` environment setter

Sets the default text color for navigation bar buttons. Default: `.primary`.

```swift
func navBarTextColor(_ color: Color) -> some View
```

---

## Array Extensions

### On `Array where Element: Identifiable`

| Method | Description |
|--------|-------------|
| `mutating func toggleItem(_ item: Element)` | Removes if found by id, appends if not |
| `mutating func addOrUpdate(_ item: Element)` | Updates in-place if found by id, appends if not |

Both perform O(n) linear scans via `firstIndex(where: { $0.id == item.id })`.

---

## Date Extensions

| Method | Returns | Description |
|--------|---------|-------------|
| `static func createDate(month:day:year:)` | `Date` | Creates a date from optional components |
| `static func randomTime(on:between:and:)` | `Date` | Random time on a given date between two hours |

---

## String Extensions

| Method | Returns | Description |
|--------|---------|-------------|
| `func skipLine(_ text: String)` | `String` | Appends text on a new line |
| `func removingExtraWhitespace()` | `String` | Collapses multiple whitespace characters |

---

## Conditional Modifier Selection Guide

| Need | Modifier | Content fate when false |
|:-----|:---------|:----------------------|
| Show/hide view | `.onlyShow(when:)` | Removed from hierarchy |
| Replace with another view | `.showingConditionalView(when:)` | Removed; replacement shown |
| Show view if optional non-nil | `.showingViewWithOptional(_:)` | Original content shown |
| Wrap as nav link | `.asNavLink(_:isActive:)` | Bare content, no link |
| Conditional nav title | `.withNavTitle(title:)` | No title applied |

---

## Best Practices

- **Use `.withNavBarDismissButton()` for standard dismiss** — Handles platform-appropriate placement automatically. Only provide a custom `dismiss` closure when you need to perform cleanup before dismissal.
- **Prefer `itemToModify` overload for discard changes** — The auto-tracking variant snapshots the original value at init. Use the `didMakeChanges` overload only when you have complex change detection logic.
- **Conditional modifiers reset `@State`** — All conditional modifiers use branching. When the condition toggles, the child view is destroyed and recreated, losing all `@State`. Design accordingly.
- **`activeOnChangeNavBarButton` never deactivates** — Once the tracked item changes, the button stays active permanently. Use it for "Save" buttons that should remain tappable after any edit.
- **`onDeviceShake` is app-wide** — The `UIWindow.motionEnded` override applies globally. Guard with `isActive` to scope the behavior.
- **Navigation button text color** — Set `.navBarTextColor()` at the root to theme all nav bar buttons. Individual buttons can override via the `textColor` parameter.
