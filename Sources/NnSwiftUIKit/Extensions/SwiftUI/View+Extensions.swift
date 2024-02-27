//
//  View+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

public extension View {
    var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func nnGetWidthPercent(_ percent: CGFloat) -> CGFloat { screenWidth * (percent * 0.01) }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func nnGetHeightPercent(_ percent: CGFloat) -> CGFloat { screenHeight * (percent * 0.01) }
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
    func nnAsyncConfirmation(showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonText: String, message: String, action: @escaping () async throws -> Void) -> some View {
        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, role: role, buttonText: buttonText, message: message, action: action))
    }
    
    func nnWithSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, buttonImage: String = "trash", deleteText: String = "Delete", delete: @escaping () async throws -> Void) -> some View {
        modifier(DeleteRowViewModifier(message: message, isActive: isActive, buttonImage: buttonImage, deleteText: deleteText, delete: delete))
    }
    
    func nnAsyncTextFieldAlert(isPresented: Binding<Bool>, title: String = "", prompt: String = "Enter name...", message: String = "Enter the name for your item", actionButtonText: String = "Save", saveItem: @escaping (String) async throws -> Void) -> some View {
        modifier(AsyncTextFieldAlertViewModifier(isPresented: isPresented, title: title, prompt: prompt, message: message, actionButtonText: actionButtonText, saveItem: saveItem))
    }
    
    func nnAsyncTextFieldAlert(isPresented: Binding<Bool>, info: AsyncTextFieldAlertInfo, saveItem: @escaping (String) async throws -> Void) -> some View {
        modifier(AsyncTextFieldAlertViewModifier(isPresented: isPresented, title: info.title, prompt: info.prompt, message: info.message, actionButtonText: info.actionButtonText, saveItem: saveItem))
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
    func nnAsRowItem(withChevron: Bool = false) -> some View {
        modifier(RowItemViewModifier(withChevron: withChevron))
    }
    
    func nnSetCustomFont(_ style: Font.TextStyle, fontName: String, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: makeFont(style, fontName: fontName), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    func nnSetCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
        modifier(CustomFontViewModifier(font: Font.custom(fontName, size: size), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
    }
    
    func nnFramePercent(widthPercent: CGFloat, heighPercent: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(FrameByScreenPercentageViewModifier(width: nnGetWidthPercent(widthPercent), height: nnGetHeightPercent(heighPercent), alignment: alignment))
    }
}


// MARK: - Navigation
public extension View {
    func nnWithNavBarButton(placement: ToolbarItemPlacement = .navigationBarTrailing, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, action: @escaping () -> Void) -> some View {
        modifier(NavBarButtonViewModifier(placement: placement, buttonContent: buttonContent, font: font, textColor: textColor, action: action))
    }
}


// MARK: - iOS 15+ Navigation
@available(iOS 15.0, *)
public extension View {
    func nnWithNavBarDismissButton(isActive: Bool = true, placement: ToolbarItemPlacement? = nil, textColor: Color = .white, dismissType: NavBarDismissType = .xmark, dismiss: (() -> Void)? = nil) -> some View {
        modifier(NavBarDismissButtonViewModifier(isActive: isActive, placement: placement, textColor: textColor, dismissType: dismissType, action: dismiss))
    }
}


// MARK: - Utility
public extension View {
    func nnDelayedOnAppear(seconds: Double, perform action: @escaping () -> Void) -> some View {
        modifier(DelayedOnAppearViewModifier(seconds: seconds, action: action))
    }
    
    func nnTappable(withChevron: Bool = false, onTapGesture: @escaping () -> Void) -> some View {
        modifier(TappableRowViewModifier(withChevron: withChevron, onTapGesture: onTapGesture))
    }
}


// MARK: - Showcase
@available(iOS 16.4, *)
public extension View {
    func nnCanShowcaseViews(showHighlights: Bool, onFinished: @escaping () -> Void) -> some View {
        modifier(ShowcaseParentViewModifier(showHighlights: showHighlights, onFinished: onFinished))
    }
    
    func nnShowcased(_ title: String, order: Int, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
        modifier(ShowcasedViewModifier(title: title, orderNumber: order, cornerRadius: cornerRadius, style: style, scale: scale))
    }
}
