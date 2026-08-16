# Error Handling API

The async error handling system, alert modifiers, and accessibility types. Built around `NnErrorHandlingContext` which manages loading state and error presentation for the entire view hierarchy.

---

## Protocol: NnDisplayableError

User-facing error protocol providing title and message for alert display. Errors conforming to this protocol surface their custom `title` and `message` in error alerts. Non-conforming errors fall back to `"Error"` and `localizedDescription`.

```swift
public protocol NnDisplayableError: Error {
    var title: String { get }  // Default: "Error"
    var message: String { get }
}
```

### Usage Example

```swift
enum MyError: NnDisplayableError {
    case notFound
    var message: String { "The item could not be found." }
    // title defaults to "Error" via default implementation
}
```

---

## Class: NnErrorHandlingContext

`@MainActor` observable object that manages global error and loading state. Created automatically by `.withNnErrorHandling()`. All async action modifiers and `AsyncTryButton` delegate to this context's `performAction` method.

```swift
@MainActor
public final class NnErrorHandlingContext: ObservableObject
```

### Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `performAction(hideLoadingIndicator: Bool, action: @escaping () async throws -> Void)` | `Void` | Wraps an async throwing action with loading state and error presentation |

### Internal Flow

1. Sets `isLoading = true` (unless `hideLoadingIndicator` is true)
2. Spawns a `Task` on `@MainActor`, awaits the action
3. On throw: creates `NnErrorAlert` from the error -> sets `showingAlert = true`
4. Always sets `isLoading = false` after completion, regardless of success/failure

If the thrown error conforms to `NnDisplayableError`, the alert uses `error.title` and `error.message`. Otherwise falls back to `"Error"` / `error.localizedDescription`.

### Usage Example

```swift
// Applied at app/screen root — injects context into environment
ContentView()
    .withNnErrorHandling(accentColor: .blue, alertButtonText: "Okay")
```

---

## Struct: AsyncTryButton\<Label: View\>

SwiftUI button that wraps async throwing actions with automatic error handling. Reads `NnErrorHandlingContext` from the environment. Requires `.withNnErrorHandling()` ancestor.

```swift
public struct AsyncTryButton<Label: View>: View
```

### Initialization

| Initializer | Description |
|-------------|-------------|
| `init(action:role:hideLoadingIndicator:hapticFeedback:label:)` | Primary initializer with ViewBuilder label |
| `init(_ titleKey:role:hideLoadingIndicator:hapticFeedback:action:)` | Convenience with `LocalizedStringKey` (where `Label == Text`) |
| `init(_ title:role:hideLoadingIndicator:hapticFeedback:action:)` | Convenience with `StringProtocol` (where `Label == Text`) |

### Nested Types

**`HapticFeedback`** — `case selection`, `case impact(style: ImpactStyle)`, `case notification(type: NotificationType)`

**`ImpactStyle`** — `case light`, `medium`, `heavy`, `soft`, `rigid`

**`NotificationType`** — `case success`, `warning`, `error`

### Behavioral Notes

- Haptics fire **before** the async action executes (even if the action will throw)
- Haptics are silently no-ops on macOS (entire implementation gated by `#if os(iOS)`)

### Usage Example

```swift
AsyncTryButton("Save", hapticFeedback: .notification(type: .success)) {
    try await saveData()
}

AsyncTryButton(action: { try await deleteItem() }, role: .destructive) {
    Label("Delete", systemImage: "trash")
}
```

---

## Struct: AccessibleItemInfo

Carries a user-facing prompt string and optional accessibility identifier. Used throughout alert and action modifiers for button labels.

```swift
public struct AccessibleItemInfo: Sendable {
    public let prompt: String
    public let accessibilityId: String?
    public init(prompt: String, accessibilityId: String? = nil)
}
```

### Usage Example

```swift
AccessibleItemInfo(prompt: "Save", accessibilityId: "saveButton")
AccessibleItemInfo(prompt: "Cancel") // no accessibility ID
```

---

## Struct: AccessibleLabelInfo

Extends `AccessibleItemInfo` with a system image name. Used for swipe action buttons that need both text and an icon.

```swift
public struct AccessibleLabelInfo {
    public let text: String
    public let systemImage: String
    public let accessibilityId: String?
    public init(text: String, systemImage: String, accessibilityId: String? = nil)
}
```

### Usage Example

```swift
AccessibleLabelInfo(text: "Delete", systemImage: "trash", accessibilityId: "deleteSwipe")
```

---

## View Modifier: `.withNnErrorHandling(accentColor:alertButtonText:)`

Root-level modifier that creates and injects `NnErrorHandlingContext` into the environment. Overlays a loading spinner (3x `ProgressView` over 50% opacity background) when loading, and presents error alerts automatically.

```swift
func withNnErrorHandling(accentColor: Color = .white, alertButtonText: String = "Okay") -> some View
```

**Must be applied before** any `AsyncTryButton` or async action modifiers in the view hierarchy.

---

## Alert Modifiers

All alert modifiers below bind the dominant button to `.keyboardShortcut(.defaultAction)` — Return triggers it on macOS, and iPad hardware keyboards behave the same. iPhones without a hardware keyboard are unaffected.

**watchOS:** the shortcut is compiled out (`#if !os(watchOS)`) — watchOS has no `keyboardShortcut` API. The same guard applies to the error alert raised by `.withNnErrorHandling()`. Buttons behave identically otherwise; only the hardware-key binding is absent.

### `.asyncAlert(_:isPresented:buttonInfo:cancelInfo:hideLoadingIndicator:action:cancelAction:alertView:)`

Presents an alert with an async action button and optional custom alert view content.

```swift
func asyncAlert<AlertView: View>(
    _ message: String,
    isPresented: Binding<Bool>,
    buttonInfo: AccessibleItemInfo? = nil,    // default: "Save"
    cancelInfo: AccessibleItemInfo? = nil,    // default: "Cancel"
    hideLoadingIndicator: Bool = false,
    action: @escaping () async throws -> Void,
    cancelAction: @escaping () -> Void = { },
    @ViewBuilder alertView: @escaping () -> AlertView
) -> some View
```

**Note:** The action button is always rendered with `.destructive` role (hard-coded). There is no parameter to override this.

### `.singleFieldAlert(_:isPresented:fieldInfo:buttonInfo:cancelInfo:hideLoadingIndicator:action:)`

Alert with a single text field. The action receives the field text.

```swift
func singleFieldAlert(
    _ message: String,
    isPresented: Binding<Bool>,
    fieldInfo: AccessibleItemInfo,
    buttonInfo: AccessibleItemInfo? = nil,
    cancelInfo: AccessibleItemInfo? = nil,
    hideLoadingIndicator: Bool = false,
    action: @escaping (String) async throws -> Void
) -> some View
```

**Note:** Field text is **not** cleared on successful submit — only cleared on cancel. This differs from `doubleFieldAlert` which clears on both success and cancel.

### `.doubleFieldAlert(_:isPresented:firstFieldInfo:secondFieldInfo:buttonInfo:cancelInfo:hideLoadingIndicator:action:)`

Alert with two text fields. Both fields are cleared on success and on cancel.

```swift
func doubleFieldAlert(
    _ message: String,
    isPresented: Binding<Bool>,
    firstFieldInfo: AccessibleItemInfo,
    secondFieldInfo: AccessibleItemInfo,
    buttonInfo: AccessibleItemInfo? = nil,
    cancelInfo: AccessibleItemInfo? = nil,
    hideLoadingIndicator: Bool = false,
    action: @escaping (String, String) async throws -> Void
) -> some View
```

### `.showingAlert(_:message:cancelInfo:isPresented:finished:)`

Simple non-async alert with a dismiss button. Button label resolves: explicit `cancelInfo` > `\.showingAlertButtonInfo` environment > `"Okay"`.

```swift
func showingAlert(
    _ title: String,
    message: String,
    cancelInfo: AccessibleItemInfo? = nil,
    isPresented: Binding<Bool>,
    finished: (() -> Void)? = nil
) -> some View
```

### `.showingError(error:)`

Presents an alert from an `Error?` binding. Uses `.constant(error != nil)` for presentation — the binding is never automatically reset to nil on dismiss.

```swift
func showingError(error: Binding<Error?>) -> some View
```

---

## Async Action Modifiers

All require `.withNnErrorHandling()` ancestor. All delegate to `NnErrorHandlingContext.performAction`.

### `.throwingTask(hideLoadingIndicator:onlyPerformOnce:perform:)`

Runs an async throwing action on view appear. Default `hideLoadingIndicator` is `true` (unlike other modifiers which default to `false`).

```swift
func throwingTask(
    hideLoadingIndicator: Bool = true,
    onlyPerformOnce: Bool = false,
    perform action: @escaping () async throws -> Void
) -> some View
```

### `.delayedOnAppear(seconds:hideLoadingIndicator:perform:)`

Runs an async action after a delay. **Warning:** If the task is cancelled during sleep, the action still fires immediately (sleep cancellation is silently swallowed via `try?`).

```swift
func delayedOnAppear(
    seconds: Double,
    hideLoadingIndicator: Bool = true,
    perform action: @escaping () async throws -> Void
) -> some View
```

### `.tappable(tapIsActive:withChevron:maxWidth:tint:alignment:hideLoadingIndicator:onTapGesture:)`

Makes a view tappable with an async throwing action. Internally applies `.asRowItem()` for layout.

```swift
func tappable(
    tapIsActive: Bool = true,
    withChevron: Bool = false,
    maxWidth: CGFloat = .infinity,
    tint: Color = .primary,
    alignment: Alignment = .leading,
    hideLoadingIndicator: Bool = false,
    onTapGesture: @escaping () async throws -> Void
) -> some View
```

### `.asyncOnSubmit(submitLabel:hideLoadingIndicator:action:)`

Async action on keyboard submit.

```swift
func asyncOnSubmit(
    submitLabel: SubmitLabel = .done,
    hideLoadingIndicator: Bool = false,
    action: @escaping () async throws -> Void
) -> some View
```

### `.asyncTapGesture(count:hideLoadingIndicator:action:)`

Async, error-handled tap gesture. Routes through `NnErrorHandlingContext.performAction`. Use this for whole-row taps where wrapping the row in a `Button`/`AsyncTryButton` would conflict with nested controls (e.g. a list row that contains its own close button).

```swift
func asyncTapGesture(
    count: Int = 1,
    hideLoadingIndicator: Bool = false,
    action: @escaping () async throws -> Void
) -> some View
```

**vs `.tappable()`** — `.tappable()` also styles the row (chevron, tint, alignment); `.asyncTapGesture()` is gesture-only. Reach for `.asyncTapGesture()` when you've already styled the row yourself and just need the tap behavior with error handling.

### `.asyncHandleURL(hideLoadingIndicator:asyncAction:)`

Async handler for opened URLs.

```swift
func asyncHandleURL(
    hideLoadingIndicator: Bool = false,
    asyncAction: @escaping (URL) async throws -> Void
) -> some View
```

### `.asyncOnChange(item:initial:hideLoadingIndicator:action:)` — iOS only

Fires async action when an optional value changes to non-nil. Changes to `nil` are observed but produce no action.

```swift
func asyncOnChange<Item: Equatable & Sendable>(
    item: Item?,
    initial: Bool = false,
    hideLoadingIndicator: Bool = false,
    action: @escaping (Item) async throws -> Void
) -> some View
```

### `.asyncConfirmation(showingConfirmation:isActive:message:role:buttonInfo:action:)`

Confirmation dialog with async action.

```swift
func asyncConfirmation(
    showingConfirmation: Binding<Bool>,
    isActive: Bool = true,
    message: String,
    role: ButtonRole? = nil,
    buttonInfo: AccessibleItemInfo,
    action: @escaping () async throws -> Void
) -> some View
```

### `.withSwipeDelete(message:isActive:skipConfirmation:swipeButtonTint:swipeButtonRole:swipeButtonInfo:alertButtonInfo:delete:)`

Swipe-to-delete with confirmation dialog. Uses both `AccessibleLabelInfo` (swipe button) and `AccessibleItemInfo` (alert button).

```swift
func withSwipeDelete(
    message: String = "Are you sure you want to delete this item?",
    isActive: Bool = true,
    skipConfirmation: Bool = false,
    swipeButtonTint: Color = .red,
    swipeButtonRole: ButtonRole? = .destructive,
    swipeButtonInfo: AccessibleLabelInfo? = nil,
    alertButtonInfo: AccessibleItemInfo? = nil,
    delete: @escaping () async throws -> Void
) -> some View
```

### `.withSwipeAction(info:systemImage:tint:edge:isActive:action:)`

Custom swipe action with async handler.

```swift
func withSwipeAction(
    info: AccessibleItemInfo,
    systemImage: String? = nil,
    tint: Color,
    edge: HorizontalEdge? = nil,
    isActive: Bool = true,
    action: @escaping () async throws -> Void
) -> some View
```

---

## Sheet Modifiers with Error Handling

Both create an independent `NnErrorHandlingContext` scoped to the sheet. Errors inside the sheet do not propagate to the parent context.

### `.sheetWithErrorHandling(isPresented:isActive:accentColor:sheet:)`

```swift
func sheetWithErrorHandling<Sheet: View>(
    isPresented: Binding<Bool>,
    isActive: Bool = true,
    accentColor: Color = .white,
    @ViewBuilder sheet: @escaping () -> Sheet
) -> some View
```

### `.sheetWithErrorHandling(item:isActive:accentColor:sheet:)`

```swift
func sheetWithErrorHandling<Item: Identifiable, Sheet: View>(
    item: Binding<Item?>,
    isActive: Bool = true,
    accentColor: Color = .white,
    @ViewBuilder sheet: @escaping (Item) -> Sheet
) -> some View
```

---

## Async Modifier Selection Guide

| Trigger | Modifier | Default hideLoadingIndicator |
|:--------|:---------|:----|
| Button tap | `AsyncTryButton` | `false` |
| View appear | `.throwingTask()` | `true` |
| View appear with delay | `.delayedOnAppear()` | `true` |
| Value change (optional, iOS) | `.asyncOnChange()` | `false` |
| Keyboard submit | `.asyncOnSubmit()` | `false` |
| URL opened | `.asyncHandleURL()` | `false` |
| Row tap (styled) | `.tappable()` | `false` |
| Bare tap gesture | `.asyncTapGesture()` | `false` |
| Swipe action | `.withSwipeAction()` | N/A (via AsyncTryButton) |
| Confirmation dialog | `.asyncConfirmation()` | N/A (via AsyncTryButton) |
| Nav bar button | `.withNavBarButton()` | N/A (via AsyncTryButton) |

---

## Error Handling Delegation Chain

```
.withNnErrorHandling()
  +-- NnErrorHandlingContextModifier (@StateObject context)
       +-- .environmentObject(context)
            |-- AsyncTryButton -> context.performAction(...)
            |-- .tappable() -> context.performAction(...)
            |-- .throwingTask() -> context.performAction(...)
            |-- .delayedOnAppear() -> context.performAction(...)
            |-- .asyncOnSubmit() -> context.performAction(...)
            |-- .asyncTapGesture() -> context.performAction(...)
            |-- .asyncHandleURL() -> context.performAction(...)
            |-- .asyncOnChange() -> context.performAction(...)
            |-- .asyncAlert() -> embeds AsyncTryButton
            |-- .singleFieldAlert() -> delegates to .asyncAlert()
            |-- .doubleFieldAlert() -> delegates to .asyncAlert()
            |-- .withSwipeDelete() -> embeds AsyncTryButton
            |-- .asyncConfirmation() -> embeds AsyncTryButton
            +-- .withNavBarButton() -> embeds AsyncTryButton
```

---

## Best Practices

- **Apply `.withNnErrorHandling()` at the root** — All async modifiers and `AsyncTryButton` require this ancestor. Apply it once at the app or screen level, not per-component.
- **Conform errors to `NnDisplayableError`** — Without conformance, error alerts show generic `localizedDescription`. Custom `title` and `message` provide better UX.
- **Use `hideLoadingIndicator: true` for background work** — `.throwingTask()` and `.delayedOnAppear()` default to hiding the spinner. Explicit async actions (buttons, submits) default to showing it.
- **Sheet error handling is scoped** — `.sheetWithErrorHandling()` creates an independent error context. Errors in sheets don't affect the parent. This is intentional — use it for modal flows.
- **`singleFieldAlert` vs `doubleFieldAlert` clearing** — `singleFieldAlert` does NOT clear the field on successful submit (only on cancel). `doubleFieldAlert` clears on both. Plan your field state accordingly.
- **`.showingError(error:)` does not auto-reset** — The error binding is not cleared on alert dismiss. Reset it manually in your view logic.
- **Haptics fire before the action** — `AsyncTryButton` haptics trigger before the async work starts, not on completion.
