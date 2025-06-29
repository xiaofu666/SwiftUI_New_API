//
//  AnimatableDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct AnimatableDemo: View {
    @State private var expand: Bool = false
    
    var body: some View {
        VStack {
            CircleShape(radius: expand ? 100 : 0)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.smooth) {
                        expand.toggle()
                    }
                }
        }
        .padding()
    }
}

#Preview {
    AnimatableDemo()
}

@Animatable
struct CircleShape: Shape {
    // 忽略某个属性的动画
//    @AnimatableIgnored
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path
                .addArc(center: .init(x: rect.midX, y: rect.midY), radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}
