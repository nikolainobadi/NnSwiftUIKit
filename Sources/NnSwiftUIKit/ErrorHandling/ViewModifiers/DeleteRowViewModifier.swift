//
//  DeleteRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/11/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DeleteRowViewModifier: ViewModifier {
    @State private var showingConfirmation = false
    
    let message: String
    let isActive: Bool
    let delete: () async throws -> Void
    
    public func body(content: Content) -> some View {
        if isActive {
            content
                .swipeActions {
                    Button(action: { showingConfirmation = true }) {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
                .nnAsyncConfirmation(showingConfirmation: $showingConfirmation, role: .destructive, buttonText: "Delete", message: message, action: delete)
        } else {
            content
        }
    }
}

@available(iOS 15.0, *)
public extension View {
    func nnWithSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, delete: @escaping () async throws -> Void) -> some View {
        modifier(DeleteRowViewModifier(message: message, isActive: isActive, delete: delete))
    }
}


