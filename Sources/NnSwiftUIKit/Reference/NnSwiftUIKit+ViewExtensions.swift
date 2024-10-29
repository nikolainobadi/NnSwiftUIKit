/// Use this file to easily 'wrap' the methods from `NnSwiftUIKit`in your app to avoid having to depend on this package throughout your app.
//
//
//import SwiftUI
//import NnSwiftUIKit
//
//public extension View {
//    var screenWidth: CGFloat {
//        #if canImport(UIKit)
//        return UIScreen.main.bounds.size.width
//        #elseif canImport(AppKit)
//        return NSScreen.main?.frame.size.width ?? 0
//        #endif
//    }
//    
//    var screenHeight: CGFloat {
//        #if canImport(UIKit)
//        return UIScreen.main.bounds.size.height
//        #elseif canImport(AppKit)
//        return NSScreen.main?.frame.size.height ?? 0
//        #endif
//    }
//    
//    func getWidthPercent(_ percent: CGFloat) -> CGFloat {
//        return screenWidth * (percent * 0.01)
//    }
//    
//    func getHeightPercent(_ percent: CGFloat) -> CGFloat {
//        return screenHeight * (percent * 0.01)
//    }
//}
//
//// MARK: - Error Handling
//public extension View {
//    func withErrorHandling() -> some View {
//        nnWithNnLoadingView()
//            .nnWithNnErrorHandling()
//    }
//    func withNnLoadingView() -> some View {
//        nnWithNnLoadingView()
//    }
//    
//    func withNnErrorHandling() -> some View {
//        nnWithNnErrorHandling()
//    }
//    
//    func sheetWithErrorHandling<Item: Identifiable, Sheet: View>(item: Binding<Item?>, isDisabled: Bool = false, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
//        nnSheetWithErrorHandling(item: item, isDisabled: isDisabled, sheet: sheet)
//    }
//    
//    func sheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
//        nnSheetWithErrorHandling(isPresented: isPresented, sheet: sheet)
//    }
//    
//    func asyncOnChange<Item: Equatable>(of item: Item?, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
//        nnAsyncOnChange(of: item, hideLoadingIndicator: hideLoadingIndicator, action: action)
//    }
//    
//    func asyncHandleURL(hideLoadingIndicator: Bool = false, asyncAction: @escaping (URL) async throws -> Void) -> some View {
//        nnAsyncHandleURL(hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction)
//    }
//    
//    func asyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
//        nnAsyncTask(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction)
//    }
//    
//    func asyncTapGesture(asRowItem: NnAsyncTapRowItem? = nil, action: @escaping () async throws -> Void) -> some View {
//        nnAsyncTapGesture(asRowItem: asRowItem, action: action)
//    }
//}
//
//
//// MARK: - iOS 15+ Error Handling
//@available(iOS 15.0, *)
//public extension View {
//    func asyncConfirmation(_ message: String, showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonInfo: AccessibleItemInfo, action: @escaping () async throws -> Void) -> some View {
//        nnAsyncConfirmation(showingConfirmation: showingConfirmation, role: role, buttonInfo: buttonInfo, message: message, action: action)
//    }
//    
//    func withSwipeDelete(_ message: String = "Are you sure you want to delete this item?", isActive: Bool = true, alertButtonInfo: AccessibleItemInfo? = nil, delete: @escaping () async throws -> Void) -> some View {
//        nnWithSwipeDelete(message: message, isActive: isActive, alertButtonInfo: alertButtonInfo, delete: delete)
//    }
//    
//    func asyncOnSubmit(submitLabel: SubmitLabel = .done, action: @escaping () async throws -> Void) -> some View {
//        nnAsyncOnSubmit(submitLabel: submitLabel, action: action)
//    }
//}
//
//
//// MARK: - Conditionals
//public extension View {
//    func onlyShow(when conditional: Bool) -> some View {
//        nnOnlyShow(when: conditional)
//    }
//    
//    func withBorderOverlay(_ showOverlay: Bool, color: Color = .red, cornerRadius: CGFloat = 10) -> some View {
//        nnWithBorderOverlay(showOverlay, color: color, cornerRadius: cornerRadius)
//    }
//    
//    func withNavTitle(title: String?) -> some View {
//        nnWithNavTitle(title: title)
//    }
//    
//    func showingConditionalView<V: View>(isShowing: Bool, @ViewBuilder conditionalView: @escaping () -> V) -> some View {
//        nnShowingConditionalView(isShowing: isShowing, conditionalView: conditionalView)
//    }
//    
//    func showingViewWithOptional<I, V: View>(_ optional: I?, @ViewBuilder conditionalView: @escaping (I) -> V) -> some View {
//        nnShowingViewWithOptional(optional, conditionalView: conditionalView)
//    }
//}
//
//
//// MARK: - iOS 16+ Conditionals
//@available(iOS 16.0, *)
//public extension View {
//    func asNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
//        nnAsNavLink(data, isActive: isActive)
//    }
//}
//
//
//// MARK: - Designs
//public extension View {
//    func setCustomFont(_ style: Font.TextStyle, fontName: String, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
//        nnSetCustomFont(style, fontName: fontName, textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor)
//    }
//    
//    func setCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
//        nnSetCustomFont(fontName: fontName, size: size, textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor)
//    }
//    
//    func asRowItem(withChevron: Bool = false, alignment: Alignment = .leading, tint: Color = .primary) -> some View {
//        nnAsRowItem(withChevron: withChevron, alignment: alignment, tint: tint)
//    }
//    
//    func textLinearGradient(_ gradient: LinearGradient) -> some View {
//        nnTextLinearGradient(gradient)
//    }
//    
//    func linearGradientBackground(_ gradient: LinearGradient, opacity: CGFloat = 1) -> some View {
//        nnLinearGradientBackground(gradient, opacity: opacity)
//    }
//    
//    func roundedButtonLinearGradientBackround(_ gradient: LinearGradient, cornerRadius: CGFloat = 10, shadowColor: Color = .primary, shadowRadius: CGFloat = 4) -> some View {
//        nnRoundedButtonLinearGradientBackround(gradient, cornerRadius: cornerRadius, shadowColor: shadowColor, shadowRadius: shadowRadius)
//    }
//}
//
//
//// MARK: - Utility
//public extension View {
//    func delayedOnAppear(seconds: Double, perform action: @escaping () -> Void) -> some View {
//        nnDelayedOnAppear(seconds: seconds, perform: action)
//    }
//    
//    func tappable(tapIsActive: Bool = true, withChevron: Bool = false, tint: Color = .primary, alignment: Alignment = .leading, onTapGesture: @escaping () -> Void) -> some View {
//        nnTappable(tapIsActive: tapIsActive, withChevron: withChevron, tint: tint, alignment: alignment, onTapGesture: onTapGesture)
//    }
//    
//    func setAccessibiltyId(_ id: String?) -> some View {
//        nnSetAccessibiltyId(id)
//    }
//    
//    @available(iOS 15.0, *)
//    func withSwipeAction(info: AccessibleItemInfo, systemImage: String? = nil, tint: Color, edge: HorizontalEdge? = nil, isActive: Bool = true, action: @escaping () -> Void) -> some View {
//        nnWithSwipeAction(info: info, systemImage: systemImage, tint: tint, edge: edge, isActive: isActive, action: action)
//    }
//    
//    func withNavBarButton(placement: ToolbarItemPlacement? = nil, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, isActive: Bool = true, accessibilityId: String? = nil, action: @escaping () -> Void) -> some View {
//        nnWithNavBarButton(placement: placement, buttonContent: buttonContent, font: font, textColor: textColor, isActive: isActive, accessibilityId: accessibilityId, action: action)
//    }
//}
//
//
//// MARK: - Alerts
//@available(iOS 15.0, *)
//public extension View {
//    func asyncAlert<AlertView: View>(_ message: String, isPresented: Binding<Bool>, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping () async throws -> Void, cancelAction: @escaping () -> Void = { }, @ViewBuilder alertView: @escaping () -> AlertView) -> some View {
//        nnAsyncAlert(message, isPresented: isPresented, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: action, cancelAction: cancelAction, alertView: alertView)
//    }
//    
//    func fieldAlert(_ message: String, isPresented: Binding<Bool>, fieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String) async throws -> Void) -> some View {
//        nnFieldAlert(message, isPresented: isPresented, fieldInfo: fieldInfo, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: action)
//    }
//    
//    func doubleFieldAlert(_ message: String, isPresented: Binding<Bool>, firstFieldInfo: AccessibleItemInfo, secondFieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String, String) async throws -> Void) -> some View {
//        nnDoubleFieldAlert(message, isPresented: isPresented, firstFieldInfo: firstFieldInfo, secondFieldInfo: secondFieldInfo, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: action)
//    }
//}
//
//
//// MARK: - Showcase
//@available(iOS 16.4, *)
//public extension View {
//    func showingAlert(_ title: String, message: String, buttonText: String = "Okay", isPresented: Binding<Bool>, finished: (() -> Void)? = nil) -> some View {
//        nnShowingAlert(title, message: message, buttonText: buttonText, isPresented: isPresented, finished: finished)
//    }
//}
//
//
//#if canImport(UIKit)
//public extension View {
//    func onShake(isActive: Bool, action: @escaping () -> Void) -> some View {
//        nnOnShake(isActive: isActive, action: action)
//    }
//    
//    func handlingVerticalPanGesture(handleSwipeDirection: @escaping (PanGestureSwipDirection) -> Void) -> some View {
//        nnHandlingVerticalPanGesture(handleSwipeDirection: handleSwipeDirection)
//    }
//    
//    func framePercent(widthPercent: CGFloat, heighPercent: CGFloat, alignment: Alignment = .center) -> some View {
//        nnFramePercent(widthPercent: widthPercent, heighPercent: heighPercent, alignment: alignment)
//    }
//}
//
//@available(iOS 15.0, *)
//public extension View {
//    func withNavBarDismissButton(isActive: Bool = true, placement: ToolbarItemPlacement? = nil, textColor: Color = .white, dismissType: NavBarDismissType = .xmark, accessibilityId: String? = nil, dismiss: (() -> Void)? = nil) -> some View {
//        nnWithNavBarDismissButton(isActive: isActive, placement: placement, textColor: textColor, dismissType: dismissType, accessibilityId: accessibilityId, dismiss: dismiss)
//    }
//    
//    func withDiscardChangesNavBarDismissButton<Item: Equatable>(_ title: String? = nil, message: String? = nil, itemToModify: Item, placement: ToolbarItemPlacement? = nil, dismissType: NavBarDismissType? = nil, accessibilityId: String? = nil, dismissButtonInfo: AccessibleItemInfo? = nil) -> some View {
//        nnWithDiscardChangesNavBarDismissButton(title, message: message, itemToModify: itemToModify, placement: placement, dismissType: dismissType, accessibilityId: accessibilityId, dismissButtonInfo: dismissButtonInfo)
//    }
//}
//
//@available(iOS 16.4, *)
//public extension View {
//    func canShowcaseViews(showHighlights: Bool, onFinished: @escaping () -> Void) -> some View {
//        nnCanShowcaseViews(showHighlights: showHighlights, onFinished: onFinished)
//    }
//    
//    func showcased(_ title: String, order: Int, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
//        nnShowcased(title, order: order, cornerRadius: cornerRadius, style: style, scale: scale)
//    }
//}
//#endif
//
//public protocol DisplayableError: NnDisplayableError {}
//
//public struct AsyncTryButton<Label>: View where Label: View {
//    @ViewBuilder var label: () -> Label
//    
//    let role: NnButtonRole?
//    let action: () async throws -> Void
//    
//    public init(action: @escaping () async throws -> Void, role: NnButtonRole? = nil, label: @escaping () -> Label) {
//        self.action = action
//        self.label = label
//        self.role = role
//    }
//    
//    public var body: some View {
//        NnAsyncTryButton(action: action, label: label)
//    }
//}
//public extension AsyncTryButton where Label == Text {
//    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
//        self.init(action: action, role: role, label: { Text(title) })
//    }
//    
//    init(_ titleKey: LocalizedStringKey, role: NnButtonRole? = nil, action: @escaping () async throws -> Void) {
//        self.init(action: action, role: role, label: { Text(titleKey) })
//    }
//}
//
//public struct TryButton<Label>: View where Label: View {
//    @ViewBuilder var label: () -> Label
//    
//    let role: NnButtonRole?
//    let action: () throws -> Void
//    
//    public init(action: @escaping () throws -> Void, role: NnButtonRole? = nil, label: @escaping () -> Label) {
//        self.action = action
//        self.label = label
//        self.role = role
//    }
//    
//    public var body: some View {
//        NnTryButton(action: action, role: role, label: label)
//    }
//}
//
//
//public extension TryButton where Label == Text {
//    init(_ titleKey: LocalizedStringKey, role: NnButtonRole? = nil, action: @escaping () throws -> Void) {
//        self.init(action: action, role: role, label: { Text(titleKey) })
//    }
//    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () throws -> Void) where S: StringProtocol {
//        self.init(action: action, role: role, label: { Text(title) })
//    }
//}
//
//public extension Array where Element: Identifiable {
//    mutating func toggleItem(_ item: Element) {
//        nnToggleItem(item)
//    }
//    
//    mutating func addOrUpdate(_ item: Element) {
//        nnAddOrUpdate(item)
//    }
//}
