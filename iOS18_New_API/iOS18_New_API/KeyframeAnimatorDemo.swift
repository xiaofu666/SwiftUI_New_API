//
//  KeyframeAnimatorDemo.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2024/9/18.
//

import SwiftUI

struct KeyframeAnimatorDemo: View {
    @State private var jumpTrigger: Bool = false
    @State private var showNumber: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing:15) {
                Text(showNumber ? "1234 7689 0098 8769" : "XXXX XXXX XXXX XX69")
                    .monospaced()
                    .fontWeight(.semibold)
                    .contentTransition(.numericText())
                
                Button {
                    withAnimation(.bouncy) {
                        showNumber.toggle()
                    }
                } label: {
                    Image(systemName:showNumber ?"eye.slash" :"eye")
                        .foregroundStyle(.purple.gradient)
                        .contentTransition(.symbolEffect(.replace))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius:10)
                    .fill(Color.purple.opacity(0.12).gradient)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .foregroundStyle(.red.gradient)
                }
                .keyframeAnimator(initialValue: Jump(), trigger: jumpTrigger) { content, value in
                    content
                        .rotationEffect(.degrees(value.rotation), anchor: .bottom)
                        .scaleEffect(y: value.scaleY, anchor: .bottom)
                        .offset(y: value.offsetY)
                } keyframes: { _ in
                    KeyframeTrack(\.scaleY) {
                        SpringKeyframe(0.4, duration: 0.2, spring: .bouncy)
                        CubicKeyframe(1.15, duration: 0.1)
                        CubicKeyframe(1.15, duration: 0.5)
                        CubicKeyframe(1, duration: 0.2)
                    }
                    KeyframeTrack(\.offsetY) {
                        SpringKeyframe(15, duration: 0.2, spring: .smooth)
                        SpringKeyframe(-12, duration: 0.6, spring: .smooth)
                        SpringKeyframe(0, duration: 0.2, spring: .smooth)
                    }
                    KeyframeTrack(\.rotation) {
                        CubicKeyframe(0, duration: 0.2)
                        CubicKeyframe(14, duration: 0.3)
                        CubicKeyframe(-14, duration: 0.3)
                        CubicKeyframe(0, duration: 0.2)
                    }
                }

            }
        }
        .task {
            try? await Task.sleep(for: .seconds(0.25))
            jumpTrigger = true
        }
    }
    
    struct Jump {
        var scaleY: CGFloat = 1
        var offsetY: CGFloat = 0
        var rotation: CGFloat = 0
    }
}

#Preview {
    KeyframeAnimatorDemo()
}
