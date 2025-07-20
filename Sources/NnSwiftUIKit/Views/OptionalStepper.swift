//
//  OptionalStepper.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 5/15/25.
//

import SwiftUI

public struct OptionalStepper: View {
    @State private var internalValue: Int
    @Binding var value: Int?
    
    let range: ClosedRange<Int>
    let label: (Int) -> Text

    public init(value: Binding<Int?>, range: ClosedRange<Int>, label: @escaping (Int) -> Text) {
        self._value = value
        self.range = range
        self.label = label
        self._internalValue = .init(initialValue: value.wrappedValue ?? range.lowerBound)
    }

    public var body: some View {
        Stepper(value: $internalValue, in: range) {
            label(internalValue)
        }
        .onChange(of: internalValue) { (_, newValue) in
            value = newValue
        }
        .onChange(of: value) { (_, newValue) in
            if let newValue, newValue != internalValue {
                internalValue = newValue
            }
        }
    }
}

