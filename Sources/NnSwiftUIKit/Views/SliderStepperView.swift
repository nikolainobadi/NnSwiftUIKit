//
//  SliderStepperView.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on 1/23/26.
//

import SwiftUI

public struct SliderStepperView<SliderContent: View, StepperContent: View>: View {
    @Binding private var value: Int

    private let range: SliderStepperRange
    private let sliderTransform: (Slider<EmptyView, EmptyView>) -> SliderContent
    private let stepperTransform: (Stepper<Text>) -> StepperContent

    public init(
        value: Binding<Int>,
        range: SliderStepperRange = .init(),
        @ViewBuilder slider: @escaping (Slider<EmptyView, EmptyView>) -> SliderContent,
        @ViewBuilder stepper: @escaping (Stepper<Text>) -> StepperContent
    ) {
        self._value = value
        self.range = range
        self.sliderTransform = slider
        self.stepperTransform = stepper
    }

    public var body: some View {
        VStack {
            sliderView
            stepperView
        }
    }
}


// MARK: - Helper Init
public extension SliderStepperView where SliderContent == Slider<EmptyView, EmptyView>, StepperContent == Stepper<Text> {
    init(
        value: Binding<Int>,
        range: SliderStepperRange = .init()
    ) {
        self.init(
            value: value,
            range: range,
            slider: { $0 },
            stepper: { $0 }
        )
    }
}


// MARK: - Subviews
private extension SliderStepperView {
    var sliderView: some View {
        sliderTransform(
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0) }
                ),
                in: Double(range.min)...Double(range.max),
                step: Double(range.sliderStep)
            )
        )
    }

    var stepperView: some View {
        stepperTransform(
            Stepper(
                "Adjust: \(value)",
                value: $value,
                in: range.min...range.max,
                step: range.stepperStep
            )
        )
    }
}


// MARK: - Dependencies
public struct SliderStepperRange: Sendable {
    public let sliderStep: Int
    public let stepperStep: Int
    public let min: Int
    public let max: Int

    public init(
        sliderStep: Int = 5,
        stepperStep: Int = 5,
        min: Int = 5,
        max: Int = 60
    ) {
        self.sliderStep = sliderStep
        self.stepperStep = stepperStep
        self.min = min
        self.max = max
    }
}


// MARK: - Preview
#if DEBUG
#Preview {
    @Previewable @State var funPoints = 25

    VStack {
        Text("Fun Points")
        
        SliderStepperView(
            value: $funPoints,
            range: .init(
                sliderStep: 10,
                stepperStep: 1,
                min: 0,
                max: 100
            ),
            slider: {
                $0
                    .tint(.orange)
            },
            stepper: {
                $0
                    .foregroundStyle(.orange)
            }
        )
    }
}
#endif
