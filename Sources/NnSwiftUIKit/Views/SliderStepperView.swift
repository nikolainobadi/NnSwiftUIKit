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
    private let spacing: CGFloat?
    private let alignment: HorizontalAlignment
    private let stepperLabel: (Int) -> Text
    private let sliderTransform: (Slider<EmptyView, EmptyView>) -> SliderContent
    private let stepperTransform: (Stepper<Text>) -> StepperContent

    /// Creates a slider and stepper pair bound to an integer value.
    ///
    /// This initializer provides full customization over layout, labeling, and styling.
    ///
    /// - Parameters:
    ///   - value: A binding to the integer value controlled by the slider and stepper.
    ///   - range: Configuration defining minimum, maximum, and step sizes for both controls.
    ///   - spacing: Optional vertical spacing between the slider and stepper. Pass `nil` to use the system default.
    ///   - alignment: Horizontal alignment of the slider and stepper within the vertical stack.
    ///   - stepperLabel: A closure that produces the stepper label based on the current value.
    ///   - slider: A view-transform closure used to customize the slider.
    ///   - stepper: A view-transform closure used to customize the stepper.
    /// - Example:
    /// ```swift
    /// SliderStepperView(
    ///     value: $points,
    ///     slider: {
    ///         $0.tint(.orange)
    ///     },
    ///     stepper: {
    ///         $0.labelsHidden()
    ///     }
    /// )
    /// ```
    public init(
        value: Binding<Int>,
        range: SliderStepperRange = .init(),
        spacing: CGFloat? = nil,
        alignment: HorizontalAlignment = .center,
        stepperLabel: @escaping (Int) -> Text,
        @ViewBuilder slider: @escaping (Slider<EmptyView, EmptyView>) -> SliderContent,
        @ViewBuilder stepper: @escaping (Stepper<Text>) -> StepperContent
    ) {
        self._value = value
        self.range = range
        self.spacing = spacing
        self.alignment = alignment
        self.stepperLabel = stepperLabel
        self.sliderTransform = slider
        self.stepperTransform = stepper
    }

    public var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            sliderView
            stepperView
        }
    }
}


// MARK: - Helper Init
public extension SliderStepperView where SliderContent == Slider<EmptyView, EmptyView>, StepperContent == Stepper<Text> {
    /// Creates a slider and stepper pair with default layout, labeling, and styling.
    ///
    /// This initializer applies identity transforms and a default stepper label.
    ///
    /// - Parameters:
    ///   - value: A binding to the integer value controlled by the slider and stepper.
    ///   - range: Configuration defining minimum, maximum, and step sizes for both controls.
    init(
        value: Binding<Int>,
        range: SliderStepperRange = .init()
    ) {
        self.init(
            value: value,
            range: range,
            spacing: nil,
            alignment: .center,
            stepperLabel: { Text("Adjust: \($0)") },
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
                value: $value,
                in: range.min...range.max,
                step: range.stepperStep
            ) {
                stepperLabel(value)
            }
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
@available(iOS 18.0, macOS 15.0, watchOS 11.0, *)
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
            spacing: 12,
            alignment: .leading,
            stepperLabel: { value in
                Text("Points: \(value)")
            },
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
