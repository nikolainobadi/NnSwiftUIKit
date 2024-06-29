//
//  OptionalText.swift
//
//
//  Created by Nikolai Nobadi on 6/29/24.
//

import SwiftUI

public struct OptionalText: View {
    let text: String?
    
    public init(_ text: String?) {
        self.text = text
    }
    
    public var body: some View {
        if let text {
            Text(text)
        }
    }
}
