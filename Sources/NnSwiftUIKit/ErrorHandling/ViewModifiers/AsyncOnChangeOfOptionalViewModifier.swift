//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 1/21/24.
//

import SwiftUI

struct AsyncOnChangeOfOptionalViewModifier<Item: Equatable>: ViewModifier {
    @EnvironmentObject var loadingHandler: NnLoadingHandler
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let item: Item?
    let hideLoadingIndicator: Bool
    let action: (Item) async throws -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: item) { value in
                guard let value = value else { return }
                
                Task {
                    loadingHandler.startLoading(isDisabled: hideLoadingIndicator)
                    
                    do {
                        try await action(value)
                    } catch {
                        errorHandler.handle(error: error)
                    }
                    
                    loadingHandler.stopLoading(isDisabled: hideLoadingIndicator)
                }
            }
    }
}
