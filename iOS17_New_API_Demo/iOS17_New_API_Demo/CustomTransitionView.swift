//
//  CustomTransitionView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct CustomTransitionView: View {
    @State private var showView: Bool = false
    var body: some View {
        VStack {
            if showView {
                Rectangle()
                    .fill(.red.gradient)
                    .frame(width: 250, height: 250)
                    .transition(MyTransition())
            }
            
            Button("Show View") {
                //  spring  interactiveSpring  smooth  snappy  bouncy
                //  弹簧 互动弹簧 光滑 敏捷 有弹性
                withAnimation(.init(MyAnimation())) {
                    showView.toggle()
                }
            }
        }
    }
}

struct MyTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotation3DEffect(
                .init(degrees: phase.value * (phase == .willAppear ? 90 : -90)),
                axis: (x: 1.0, y: 0.0, z: 0.0)
            )
    }
}

struct MyAnimation: CustomAnimation {
    var duration: CGFloat = 1
    
    func animate<V>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? where V : VectorArithmetic {
        if time > duration { return nil }
        return value.scaled(by: easeOutBounce(time / duration))
    }
    
    func easeOutBounce(_ x: TimeInterval) -> CGFloat {
        let n = 7.5625
        let d = 2.75
        var x: TimeInterval = x
        if (x < 1 / d) {
            return n * x * x
        } else if (x < 2 / d) {
            x -= 1.5 / d
            return n * x * x + 0.75
        } else if (x < 2.5 / d) {
            x -= 2.25 / d
            return n * x * x + 0.9375
        } else {
            x -= 2.625 / d
            return n * x * x + 0.984375
        }
    }
}

#Preview {
    CustomTransitionView()
}
