//
//  KeyframeAnimationDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct KeyframeAnimationDemo: View {
    @State private var startKeyframeAnimation: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.xcodeBeta)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .keyframeAnimator(initialValue: Keyframe(), trigger: startKeyframeAnimation) { view, frame in
                    view
                        .scaleEffect(frame.scale)
                        .rotationEffect(frame.rotation, anchor: .bottom)
                        .offset(y: frame.offsetY) 
                        .background {
                            view
                                .blur(radius: 3.0)
                                .rotation3DEffect(
                                    .init(degrees: 180),
                                    axis: (x: 1.0, y: 0.0, z: 0.0)
                                )
                                .mask({
                                    LinearGradient(colors: [
                                        .white.opacity(frame.reflectOpacity),
                                        .white.opacity(frame.reflectOpacity - 0.3),
                                        .white.opacity(frame.reflectOpacity - 0.45),
                                        .clear
                                    ], startPoint: .top, endPoint: .bottom)
                                })
                                .offset(y: 200 - frame.offsetY)
                        }
                } keyframes: { frame in
                    KeyframeTrack(\.offsetY) {
                        CubicKeyframe(20, duration: 0.15)
                        SpringKeyframe(-100, duration: 0.3, spring: .bouncy)
                        CubicKeyframe(-100, duration: 0.3)
                        SpringKeyframe(0, duration: 0.15, spring: .bouncy)
                    }
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.9, duration: 0.15)
                        CubicKeyframe(1.2, duration: 0.6)
                        CubicKeyframe(1.0, duration: 0.15)
                    }
                    KeyframeTrack(\.rotation) {
                        CubicKeyframe(.zero, duration: 0.15)
                        CubicKeyframe(.zero, duration: 0.3)
                        CubicKeyframe(.init(degrees: -20), duration: 0.1)
                        CubicKeyframe(.init(degrees: 20), duration: 0.1)
                        CubicKeyframe(.init(degrees: -20), duration: 0.1)
                        CubicKeyframe(.init(degrees: 0), duration: 0.15)
                    }
                    KeyframeTrack(\.reflectOpacity) {
                        CubicKeyframe(0.5, duration: 0.15)
                        CubicKeyframe(0.1, duration: 0.45)
                        CubicKeyframe(0.5, duration: 0.3)
                    }
                }

            
            Spacer()
            
            Button("Keyframe Animation") {
                startKeyframeAnimation.toggle()
            }
            .fontWeight(.bold)
        }
        .padding()
    }
}

struct Keyframe {
    var scale: CGFloat = 1
    var offsetY: CGFloat = 0
    var rotation: Angle = .zero
    var reflectOpacity: CGFloat = 0.5
}

#Preview {
    KeyframeAnimationDemo()
}
