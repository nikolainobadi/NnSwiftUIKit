//
//  ThrowingTaskViewModifier.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/11/25.
//

import SwiftUI

struct ThrowingTaskViewModifier: ViewModifier {
    @State private var didPerformTask = false
    @EnvironmentObject var context: NnErrorHandlingContext
    
    let onlyPerformOnce: Bool
    let hideLoadingIndicator: Bool
    let action: () async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .task {
                if onlyPerformOnce, didPerformTask {
                    return
                }
                
                context.performAction(hideLoadingIndicator: hideLoadingIndicator, action: action)
                
                if onlyPerformOnce {
                    didPerformTask = true
                }
            }
    }
}

public extension View {
    func throwingTask(hideLoadingIndicator: Bool = true, onlyPerformOnce: Bool = false, perform action: @escaping () async throws -> Void) -> some View {
        modifier(ThrowingTaskViewModifier(onlyPerformOnce: onlyPerformOnce, hideLoadingIndicator: hideLoadingIndicator, action: action))
    }
}
