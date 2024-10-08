//
//  View+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

public extension View {
    var screenWidth: CGFloat {
        #if canImport(UIKit)
        return UIScreen.main.bounds.size.width
        #elseif canImport(AppKit)
        return NSScreen.main?.frame.size.width ?? 0
        #endif
    }
    
    var screenHeight: CGFloat {
        #if canImport(UIKit)
        return UIScreen.main.bounds.size.height
        #elseif canImport(AppKit)
        return NSScreen.main?.frame.size.height ?? 0
        #endif
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func nnGetWidthPercent(_ percent: CGFloat) -> CGFloat {
        return screenWidth * (percent * 0.01)
    }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func nnGetHeightPercent(_ percent: CGFloat) -> CGFloat {
        return screenHeight * (percent * 0.01)
    }
}


// MARK: - Error Handling
public extension View {
    func nnWithNnLoadingView() -> some View {
        modifier(LoadingViewModifier())
    }
    
    func nnWithNnErrorHandling() -> some View {
        modifier(ErrorHandlingViewModifier())
    }
    
    func nnSheetWithErrorHandling<Item: Identifiable, Sheet: View>(item: Binding<Item?>, isDisabled: Bool = false, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
        modifier(ItemSheetErrorHandlingViewModifier(item: item, isDisabled: isDisabled, sheet: sheet))
    }
    
    func nnSheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(SheetErrorHandlingViewModifier(isPresented: isPresented, sheet: sheet))
    }
    
    func nnAsyncOnChange<Item: Equatable>(of item: Item?, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
        modifier(AsyncOnChangeOfOptionalViewModifier(item: item, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
    
    func nnAsyncHandleURL(hideLoadingIndicator: Bool = false, asyncAction: @escaping (URL) async throws -> Void) -> some View {
        modifier(AsyncOpenURLViewModifier(hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
    
    func nnAsyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTaskOnAppearViewModifier(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
    }
    
    func nnAsyncTapGesture(asRowItem: NnAsyncTapRowItem? = nil, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryTapGestureViewModifier(asRowItem: asRowItem, action: action))
    }
}


// MARK: - iOS 15+ Error Handling
@available(iOS 15.0, *)
public extension View {
    func nnAsyncConfirmation(showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonInfo: AccessibleItemInfo, message: String, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, role: role, buttonInfo: buttonInfo, message: message, action: action))
    }
    
    func nnWithSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, alertButtonInfo: AccessibleItemInfo? = nil, delete: @escaping () async throws -> Void) -> some View {
        modifier(DeleteRowViewModifier(message: message, isActive: isActive, alertButtonInfo: alertButtonInfo ?? .init(prompt: "Delete"), delete: delete))
    }
    
    func nnAsyncOnSubmit(submitLabel: SubmitLabel = .done, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncTryOnSubmitViewModifier(submitLabel: submitLabel, action: action))
    }
}


// MARK: - Conditionals
public extension View {
    func nnOnlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
    
    func nnWithBorderOverlay(_ showOverlay: Bool, color: Color = .red, cornerRadius: CGFloat = 10) -> some View {
        modifier(ConditionalBorderOverlayViewModifier(color: color, showOverlay: showOverlay, cornerRadius: cornerRadius))
    }
    
    func nnWithNavTitle(title: String?) -> some View {
        modifier(ConditionalNavTitleViewModifier(title: title))
    }
}


// MARK: - iOS 16+ Conditionals
@available(iOS 16.0, *)
public extension View {
    func nnAsNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
    }
}


// MARK: - Designs
public extension View {
    func nnSetCustomFont(_ style: Font.TextStyle, fontName: String, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: makeFont(style, fontName: fontName), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    func nnSetCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: Font.custom(fontName, size: size), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    func nnAsRowItem(withChevron: Bool = false, alignment: Alignment = .leading, tint: Color = .primary) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron, tint: tint, alignment: alignment))
    }
    
    func nnTextLinearGradient(_ gradient: LinearGradient) -> some View {
        modifier(LinearGradientTextColorViewModifier(gradient: gradient))
    }
    
    func nnLinearGradientBackground(_ gradient: LinearGradient, opacity: CGFloat = 1) -> some View {
        modifier(GradientBackgroundViewModifier(gradient: gradient, opacity: opacity))
    }
    
    func nnRoundedButtonLinearGradientBackround(_ gradient: LinearGradient, cornerRadius: CGFloat = 10, shadowColor: Color = .primary, shadowRadius: CGFloat = 4) -> some View {
        modifier(ButtonGradientBackgroundViewModifier(gradient: gradient, cornerRadius: cornerRadius, shadowColor: shadowColor, shadowRadius: shadowRadius))
    }
}


// MARK: - Utility
public extension View {
    func nnDelayedOnAppear(seconds: Double, perform action: @escaping () -> Void) -> some View {
        modifier(DelayedOnAppearViewModifier(seconds: seconds, action: action))
    }
    
    func nnTappable(tapIsActive: Bool = true, withChevron: Bool = false, tint: Color = .primary, alignment: Alignment = .leading, onTapGesture: @escaping () -> Void) -> some View {
        modifier(TappableRowViewModifier(tapIsActive: tapIsActive, withChevron: withChevron, tint: tint, alignment: alignment, onTapGesture: onTapGesture))
    }
    
    func nnSetAccessibiltyId(_ id: String?) -> some View {
        modifier(AccessibilityIdViewModifier(accessibilityId: id))
    }
    
    @available(iOS 15.0, *)
    func nnWithSwipeAction(info: AccessibleItemInfo, systemImage: String? = nil, tint: Color, edge: HorizontalEdge? = nil, isActive: Bool = true, action: @escaping () -> Void) -> some View {
        modifier(CustomSwipeActionViewModifier(info: info, systemImage: systemImage, edge: edge ?? .trailing, tint: tint, isActive: isActive, action: action))
    }
    
    func nnWithNavBarButton(placement: ToolbarItemPlacement? = nil, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, isActive: Bool = true, accessibilityId: String? = nil, action: @escaping () -> Void) -> some View {
        modifier(NavBarButtonViewModifier(placement: placement ?? .automatic, buttonContent: buttonContent, accessibilityId: accessibilityId, font: font, textColor: textColor, isActive: isActive, action: action))
    }
}


// MARK: - Alerts
@available(iOS 15.0, *)
public extension View {
    func nnAsyncAlert<AlertView: View>(_ message: String, isPresented: Binding<Bool>, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping () async throws -> Void, cancelAction: @escaping () -> Void = { }, @ViewBuilder alertView: @escaping () -> AlertView) -> some View {
        modifier(
            CustomAlertViewModifier(
                isPresented: isPresented,
                message: message,
                buttonInfo: buttonInfo ?? .init(prompt: "Save", accessibilityId: nil),
                cancelInfo: cancelInfo ?? .init(prompt: "Cancel", accessibilityId: nil),
                action: action,
                cancelAction: cancelAction,
                alertView: alertView
            )
        )
    }
    
    func nnFieldAlert(_ message: String, isPresented: Binding<Bool>, fieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String) async throws -> Void) -> some View {
        modifier(FieldAlertViewModifier(isPresented: isPresented, message: message, fieldInfo: fieldInfo, buttonInfo: buttonInfo, cancelInfo: cancelInfo, action: action))
    }
    
    func nnDoubleFieldAlert(_ message: String, isPresented: Binding<Bool>, firstFieldInfo: AccessibleItemInfo, secondFieldInfo: AccessibleItemInfo, buttonInfo: AccessibleItemInfo? = nil, cancelInfo: AccessibleItemInfo? = nil, action: @escaping (String, String) async throws -> Void) -> some View {
        modifier(
            DoubleFieldAlertViewModifier(
                isPresented: isPresented,
                message: message,
                firstFieldInfo: firstFieldInfo,
                secondFieldInfo: secondFieldInfo,
                buttonInfo: buttonInfo,
                cancelInfo: cancelInfo,
                action: action
            )
        )
    }
}


// MARK: - Showcase
@available(iOS 16.4, *)
public extension View {
    func nnShowingAlert(_ title: String, message: String, buttonText: String = "Okay", isPresented: Binding<Bool>, finished: (() -> Void)? = nil) -> some View {
        modifier(ShowingAlertViewModifier(presented: isPresented, title: title, message: message, buttonText: buttonText, finished: finished))
    }
}

#if canImport(UIKit)
public extension View {
    func nnOnShake(isActive: Bool, action: @escaping () -> Void) -> some View {
        modifier(DeviceShakeViewModifier(isActive: isActive, action: action))
    }
    
    func nnHandlingVerticalPanGesture(handleSwipeDirection: @escaping (PanGestureSwipDirection) -> Void) -> some View {
        modifier(PanGestureViewModifier(handleSwipeDirection: handleSwipeDirection))
    }
    
    func nnFramePercent(widthPercent: CGFloat, heighPercent: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(FrameByScreenPercentageViewModifier(width: nnGetWidthPercent(widthPercent), height: nnGetHeightPercent(heighPercent), alignment: alignment))
    }
}

@available(iOS 15.0, *)
public extension View {
    func nnWithNavBarDismissButton(isActive: Bool = true, placement: ToolbarItemPlacement? = nil, textColor: Color = .white, dismissType: NavBarDismissType = .xmark, accessibilityId: String? = nil, dismiss: (() -> Void)? = nil) -> some View {
        modifier(NavBarDismissButtonViewModifier(isActive: isActive, placement: placement, textColor: textColor, dismissType: dismissType, accessibilityId: accessibilityId, action: dismiss))
    }
    
    func nnWithDiscardChangesNavBarDismissButton<Item: Equatable>(_ title: String? = nil, message: String? = nil, itemToModify: Item, placement: ToolbarItemPlacement? = nil, dismissType: NavBarDismissType? = nil, accessibilityId: String? = nil, dismissButtonInfo: AccessibleItemInfo? = nil) -> some View {
        modifier(DiscardChangesViewModifier(title, itemToModify: itemToModify, message: message, placement: placement, dismissType: dismissType, accessibilityId: accessibilityId, dismissButtonInfo: dismissButtonInfo))
    }
}

@available(iOS 16.4, *)
public extension View {
    func nnCanShowcaseViews(showHighlights: Bool, onFinished: @escaping () -> Void) -> some View {
        modifier(ShowcaseParentViewModifier(showHighlights: showHighlights, onFinished: onFinished))
    }
    
    func nnShowcased(_ title: String, order: Int, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
        modifier(ShowcasedViewModifier(title: title, orderNumber: order, cornerRadius: cornerRadius, style: style, scale: scale))
    }
}
#endif
