//
//  MeshGradientDemo.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/17.
//

import SwiftUI

struct MeshGradientDemo: View {
    @State private var top: [MeshPoint] = [
        .init(x: 0.0, y: 0.0), .init(x: 0.5, y: 0.0), .init(x: 1.0, y: 0.0)
    ]
    @State private var center: [MeshPoint] = [
        .init(x: 0.0, y: 0.5), .init(x: 0.5, y: 0.5), .init(x: 1.0, y: 0.5)
    ]
    @State private var bottom: [MeshPoint] = [
        .init(x: 0.0, y: 1.0), .init(x: 0.5, y: 1.0), .init(x: 1.0, y: 1.0)
    ]
    
    @State private var isShowCircle: Bool = false
    
    var body: some View {
        VStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    .p(top[0]), .p(top[1]), .p(top[2]),
                    .p(center[0]), .p(center[1]), .p(center[2]),
                    .p(bottom[0]), .p(bottom[1]), .p(bottom[2]),
                ],
                colors: [
                    .red, .orange, .yellow,
                    .green, .cyan, .blue,
                    .purple, .mint, .pink
                ]
            )
            .overlay {
                GeometryReader {
                    let size = $0.size
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            CircleView($top[0], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($top[1], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($top[2], size, true)
                                .opacity(isShowCircle ? 1 : 0)
                        }
                        
                        HStack(spacing: 0) {
                            CircleView($center[0], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($center[1], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($center[2], size, true)
                                .opacity(isShowCircle ? 1 : 0)
                        }
                        .frame(maxHeight: .infinity)
                        
                        HStack(spacing: 0) {
                            CircleView($bottom[0], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($bottom[1], size)
                                .opacity(isShowCircle ? 1 : 0)
                            CircleView($bottom[2], size, true)
                                .opacity(isShowCircle ? 1 : 0)
                        }
                    }
                }
            }
            .coordinateSpace(.named("MESH"))
            
            HStack {
                Button("打印描点") {
                    print(".init(x: \(top[0].x), y: \(top[0].y)), .init(x: \(top[1].x), y: \(top[1].y)), .init(x: \(top[2].x), y: \(top[2].y))")
                    print(".init(x: \(center[0].x), y: \(center[0].y)), .init(x: \(center[1].x), y: \(center[1].y)), .init(x: \(center[2].x), y: \(center[2].y))")
                    print(".init(x: \(bottom[0].x), y: \(bottom[0].y)), .init(x: \(bottom[1].x), y: \(bottom[1].y)), .init(x: \(bottom[2].x), y: \(bottom[2].y))")
                }
                .frame(maxWidth: .infinity)
                .opacity(top[0].x != 0 ? 1 : 0)
                
                Button(top[0].x != 0 ? "还原" : "开始动画") {
                    if top[0].x != 0 {
                        withAnimation(.snappy(duration: 1.0)) {
                            top = [
                                .init(x: 0.0, y: 0.0), .init(x: 0.5, y: 0.0), .init(x: 1.0, y: 0.0)
                            ]
                            center = [
                                .init(x: 0.0, y: 0.5), .init(x: 0.5, y: 0.5), .init(x: 1.0, y: 0.5)
                            ]
                            bottom = [
                                .init(x: 0.0, y: 1.0), .init(x: 0.5, y: 1.0), .init(x: 1.0, y: 1.0)
                            ]
                        }
                    } else {
                        withAnimation(.snappy(duration: 1.0)) {
                            isShowCircle = false
                            top = [
                                .init(x: 0.07124682, y: 0.58087176), .init(x: 0.4274809, y: 0.40742964), .init(x: 0.19592875, y: 0.21259177)
                            ]
                            center = [
                                .init(x: 0.16369803, y: 0.8285161), .init(x: 0.32824427, y: 0.7065149), .init(x: 0.668363, y: 0.15022546)
                            ]
                            bottom = [
                                .init(x: 0.81933844, y: 0.6277603), .init(x: 0.5077938, y: 0.9043819), .init(x: 0.17642069, y: 0.40151167)
                            ]
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                Button("显示锚点") {
                    isShowCircle.toggle()
                }
                .frame(maxWidth: .infinity)
                .opacity(top[0].x == 0 ? 1 : 0)
            }
        }
    }
    
    @ViewBuilder
    func CircleView(_ point: Binding<MeshPoint>, _ size: CGSize, _ isLast: Bool = false) -> some View {
        Circle()
            .fill(.black)
            .frame(width: 10, height: 10)
            .contentShape(.rect)
            .offset(point.wrappedValue.offset)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named("MESH"))
                    .onChanged { value in
                        let location = value.location
                        let x = Float(location.x / size.width)
                        let y = Float(location.y / size.height)
                        
                        point.wrappedValue.x = x
                        point.wrappedValue.y = y
                        
                        let offset = value.translation
                        let lastOffset = point.wrappedValue.lastOffset
                        
                        point.wrappedValue.offset = offset + lastOffset
                    }
                    .onEnded { value in
                        point.wrappedValue.lastOffset = point.wrappedValue.offset
                    }
            )
        
        if !isLast {
            Spacer(minLength: 0)
        }
    }
}

struct MeshPoint {
    var x: Float
    var y: Float
    
    var offset: CGSize
    var lastOffset: CGSize
    
    init(x: Float, y: Float, offset: CGSize = .zero, lastOffset: CGSize = .zero) {
        self.x = x
        self.y = y
        self.offset = offset
        self.lastOffset = lastOffset
    }
}

extension SIMD2<Float> {
    static func p(_ point: MeshPoint) -> Self {
        return .init(point.x, point.y)
    }
}

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        return .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

#Preview {
    MeshGradientDemo()
}
