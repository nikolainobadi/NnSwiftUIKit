# Appearance API

Font customization system, styling modifiers, gradient backgrounds, and visual transforms. The font system uses protocol-based sizing with environment-level configuration.

---

## Protocol: FontSizeProvider

Protocol defining font size calculation logic based on screen dimensions. Injected via environment.

```swift
public protocol FontSizeProvider: Sendable {
    func makeFont(_ style: Font.TextStyle, fontName: String, screenSize: CGSize) -> Font
    func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat
}
```

### Default Implementation

`makeFont` has a default implementation that calls `Font.custom(fontName, size: makeFontSize(...))`. Conforming types only need to implement `makeFontSize`.

### Usage Example

```swift
struct MyFontProvider: FontSizeProvider {
    func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat {
        return screenSize.height * 0.02
    }
}

ContentView()
    .fontSizeProvider(MyFontProvider())
```

---

## Struct: DefaultFontSizeProvider

Default implementation of `FontSizeProvider` using percentage-based calculations relative to screen dimensions.

```swift
public struct DefaultFontSizeProvider: FontSizeProvider {
    public let useLegacyScaling: Bool
    public init(useLegacyScaling: Bool = false)
}
```

### Platform Behavior

| Platform | Base Calculation | Notes |
|----------|-----------------|-------|
| iOS (`useLegacyScaling: false`) | `max(width, height)` | Larger dimension drives sizing regardless of orientation |
| iOS (`useLegacyScaling: true`) | `screenSize.height` | Legacy behavior |
| macOS | Fixed base `17` | Screen size is ignored entirely |
| watchOS | Fixed pixel values per style | No calculation, returns hard-coded sizes |

### Usage Example

```swift
ContentView()
    .fontSizeProvider(DefaultFontSizeProvider()) // default, uses max dimension
    .fontSizeProvider(DefaultFontSizeProvider(useLegacyScaling: true)) // legacy
```

---

## Struct: FontConfiguration

Configurable defaults for text appearance. Set via environment to apply app-wide. Individual `.withFont()` calls can override per-use.

```swift
public struct FontConfiguration: Sendable {
    public var textColor: Color
    public var textLayout: NnTextLayout
    public var detailFontName: String
    public var nonDetailFontName: String
    public init(
        textColor: Color = .primary,
        textLayout: NnTextLayout = .unlimited,
        detailFontName: String = "HelveticaNeue",
        nonDetailFontName: String = "HelveticaNeue-Bold"
    )
}
```

### Usage Example

```swift
ContentView()
    .fontConfiguration(FontConfiguration(
        textColor: .white,
        textLayout: .multiLine(limit: 3),
        detailFontName: "MyFont-Light",
        nonDetailFontName: "MyFont-Bold"
    ))
```

---

## Enum: NnTextLayout

Controls text line behavior applied by `.withFont()`.

```swift
public enum NnTextLayout: Sendable {
    case unlimited                              // fixedSize(horizontal: false, vertical: true)
    case multiLine(limit: Int)                  // lineLimit(limit)
    case singleLineAutoSize(minScale: CGFloat)  // lineLimit(1) + minimumScaleFactor(minScale)
}
```

### Static Members

| Member | Value | Description |
|--------|-------|-------------|
| `.autoSize` | `.singleLineAutoSize(minScale: 0.5)` | Convenience for single-line auto-shrinking at 50% minimum |

---

## Enum: Image.ImageType

Unified image source type used across navigation and toggle modifiers.

```swift
public enum Image.ImageType {
    case system(String)         // SF Symbol
    case media(String, Bundle?) // Asset catalog image
}
```

### Usage Example

```swift
Image(imageType: .system("plus"))
Image(imageType: .media("customIcon", nil))
```

---

## Struct: ToggleCheckboxStyle

Custom `ToggleStyle` rendering as a checkbox with SF Symbol images.

```swift
public struct ToggleCheckboxStyle: ToggleStyle
```

### Static Factory

```swift
static func checkboxToggleStyle(
    tint: Color = .green,
    onImage: Image.ImageType = .system("checkmark.square"),
    offImage: Image.ImageType = .system("square")
) -> ToggleCheckboxStyle
```

### Usage Example

```swift
Toggle("Agree", isOn: $agreed)
    .toggleStyle(.checkboxToggleStyle(tint: .blue))
```

---

## Enum: UnfoldLayoutBehavior

Controls how the `.unfold()` animation handles layout space when collapsed.

```swift
public enum UnfoldLayoutBehavior {
    case occupiesSpace  // Invisible but maintains layout space (mask-based)
    case removesSpace   // Collapses to zero height, releasing space (frame-based)
}
```

---

## Struct: IsPreviewKey

Environment key for detecting SwiftUI preview context.

```swift
public struct IsPreviewKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}
```

Access via `@Environment(\.isPreview) var isPreview`.

---

## Font Modifiers

### `.withFont(_:isDetail:textColor:layout:)`

Applies a dynamic font using environment `FontSizeProvider` and `FontConfiguration`. Font name selected by `isDetail` parameter: `true` -> `detailFontName`, `false` -> `nonDetailFontName`.

```swift
func withFont(
    _ style: Font.TextStyle = .body,
    isDetail: Bool = false,
    textColor: Color? = nil,   // falls back to FontConfiguration.textColor
    layout: NnTextLayout? = nil // falls back to FontConfiguration.textLayout
) -> some View
```

### `.withFont(_:fontName:textColor:layout:)`

Applies a font with an explicit font name, bypassing `FontConfiguration`'s font names. Color and layout still fall back to environment.

```swift
func withFont(
    _ style: Font.TextStyle = .body,
    fontName: String,
    textColor: Color? = nil,
    layout: NnTextLayout? = nil
) -> some View
```

### Usage Example

```swift
Text("Title").withFont(.headline)
Text("Body text").withFont(.body, isDetail: true)
Text("Custom").withFont(.title, fontName: "Georgia-Bold", textColor: .blue)
Text("Shrinks").withFont(.body, layout: .autoSize)
```

---

## Environment Setters

| Method | Environment Key | Default |
|--------|----------------|---------|
| `.fontConfiguration(_:)` | `\.fontConfiguration` | `FontConfiguration()` |
| `.fontSizeProvider(_:)` | `\.fontSizeProvider` | `DefaultFontSizeProvider()` |
| `.rowItemTint(_:)` | `\.rowItemTint` | `.primary` |
| `.showingAlertButtonInfo(_:)` | `\.showingAlertButtonInfo` | `AccessibleItemInfo(prompt: "Okay")` |

---

## Styling Modifiers

### `.asRowItem(withChevron:maxWidth:alignment:tint:)`

Lays out content in an `HStack` with optional chevron. Always applies `.contentShape(.rect)` making the entire rectangle tappable.

```swift
func asRowItem(
    withChevron: Bool = false,
    maxWidth: CGFloat = .infinity,
    alignment: Alignment = .leading,
    tint: Color? = nil // falls back to \.rowItemTint environment
) -> some View
```

### `.linearGradientBackground(_:opacity:)`

Applies a linear gradient background that ignores safe areas.

```swift
func linearGradientBackground(_ gradient: LinearGradient, opacity: CGFloat? = nil) -> some View
```

### `.roundedButtonLinearGradientBackround(_:cornerRadius:shadowColor:shadowRadius:)`

Rounded button with gradient background. Internally calls `.linearGradientBackground()`.

```swift
func roundedButtonLinearGradientBackround(
    _ gradient: LinearGradient,
    cornerRadius: CGFloat? = nil,
    shadowColor: Color? = nil,
    shadowRadius: CGFloat? = nil
) -> some View
```

### `.textLinearGradient(_:)`

Applies a gradient color overlay to text. Uses `gradient.mask(content)` in an overlay.

```swift
func textLinearGradient(_ gradient: LinearGradient) -> some View
```

### `.disableButton(_:)`

Disables interaction and reduces opacity to 50%.

```swift
func disableButton(_ isDisabled: Bool) -> some View
```

### `.withEmptyListView(title:message:systemImage:listEmpty:)`

Replaces content with an empty state view when `listEmpty` is true. Uses `.withFont()` internally for text styling.

```swift
func withEmptyListView(
    title: String,
    message: String,
    systemImage: String = "tray",
    listEmpty: Bool
) -> some View
```

### `.withBorderOverlay(_:color:cornerRadius:)`

Conditional rounded rectangle border overlay.

```swift
func withBorderOverlay(_ showOverlay: Bool, color: Color? = nil, cornerRadius: CGFloat? = nil) -> some View
```

### `.unfold(when:behavior:animation:)`

Expand/collapse animation. See `UnfoldLayoutBehavior` for space handling.

```swift
func unfold(
    when isExpanded: Bool,
    behavior: UnfoldLayoutBehavior = .removesSpace,
    animation: Animation = .easeInOut
) -> some View
```

### `.setOptionalAccessibiltyId(_:)`

Applies an accessibility identifier only if the value is non-nil.

```swift
func setOptionalAccessibiltyId(_ id: String?) -> some View
```

---

## Font System Delegation Chain

```
.withFont(style, isDetail:, textColor:, layout:)
  +-- CustomFontViewModifier (.dynamic source)
       |-- @Environment(\.fontSizeProvider) -> makeFontSize() -> Font.custom(name, size:)
       +-- @Environment(\.fontConfiguration)
            |-- getFontName(isDetail:) -> detailFontName or nonDetailFontName
            |-- textColor (fallback)
            +-- textLayout (fallback)

.withFont(style, fontName:, textColor:, layout:)
  +-- CustomFontViewModifier (.fontName source)
       |-- @Environment(\.fontSizeProvider) -> makeFontSize() -> Font.custom(name, size:)
       +-- @Environment(\.fontConfiguration) -> textColor + layout ONLY (fontName overrides)
```

---

## View Extensions (Non-watchOS)

```swift
var screenWidth: CGFloat   // UIScreen.main.bounds.width (iOS) / NSScreen.main?.frame.width (macOS)
var screenHeight: CGFloat  // UIScreen.main.bounds.height (iOS) / NSScreen.main?.frame.height (macOS)
func getWidthPercent(_ percent: CGFloat) -> CGFloat   // screenWidth * (percent * 0.01)
func getHeightPercent(_ percent: CGFloat) -> CGFloat   // screenHeight * (percent * 0.01)
```

---

## Best Practices

- **Set font environment at the root** — Apply `.fontConfiguration()` and `.fontSizeProvider()` once near the app root. All `.withFont()` calls inherit from environment.
- **Use `isDetail: true` for secondary text** — Maps to `detailFontName` in `FontConfiguration`, providing visual hierarchy without hardcoding font names.
- **`DefaultFontSizeProvider` ignores screen size on macOS** — Uses a fixed base of `17` regardless of screen dimensions. Provide a custom `FontSizeProvider` if you need screen-relative sizing on macOS.
- **`.unfold` with `.removesSpace` causes view identity changes** — Siblings will reflow when the view collapses. Use `.occupiesSpace` to maintain stable layout.
- **`.asRowItem()` makes entire area tappable** — Due to `.contentShape(.rect)`, even transparent areas respond to taps. This is intentional for row-style layouts.
- **Gradient modifiers ignore safe areas** — `.linearGradientBackground()` applies `.ignoresSafeArea()`. The gradient extends under status bar and home indicator.
