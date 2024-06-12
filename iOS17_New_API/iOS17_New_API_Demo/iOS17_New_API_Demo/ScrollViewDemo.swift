//
//  ScrollViewDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct ScrollViewDemo: View {
    var body: some View {
        VStack {
            ScrollViewDemo1()
            Text("第一种分页： 固定宽度")
            ScrollViewDemo2()
            Text("第二种分页： 居中")
            ScrollViewDemo3()
            Text("第三种分页： 固定宽度且居中")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScrollViewDemo1: View {
    var body: some View {
        ScrollView(.horizontal) {
            let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
            
            LazyHStack(spacing: 25, content: {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(color.gradient)
//                        .frame(height: 250)
                        //第一种分页。 固定宽度
                        .frame(width: 250)
                }
            })
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

struct ScrollViewDemo2: View {
    var body: some View {
        ScrollView(.horizontal) {
            let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
            
            LazyHStack(spacing: 25, content: {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(color.gradient)
//                        .frame(height: 250)
                        //第二种分页。居中分页
                        .padding(.horizontal)
                        .containerRelativeFrame(.horizontal)
                }
            })
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

struct ScrollViewDemo3: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(.horizontal) {
                let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
                
                LazyHStack(spacing: 25, content: {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(color.gradient)
                            //第三种分页。 固定宽度且居中
                            .frame(width: 300)
                    }
                })
                .padding(.horizontal, (geometry.size.width - 300) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        })
//        .frame(height: 250)
    }
}

struct ScrollViewDemo4: View {
    @State private var scrollPosition: Color?
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(.horizontal) {
                let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
                
                LazyHStack(spacing: 25, content: {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(color.gradient)
                            //第三种分页。 固定宽度且居中
                            .frame(width: 300)
                    }
                })
                .padding(.horizontal, (geometry.size.width - 300) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition)
        })
        .frame(height: 250)
        .overlay(alignment: .bottom) {
            Button("Scroll To Yellow") {
                withAnimation(.snappy) {
                    scrollPosition = .yellow
                }
            }
            .offset(y: 50)
        }
    }
}


struct ScrollViewDemo5: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 25, content: {
                ForEach(1...20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.red.gradient)
                        .frame(height: 155)
                        .scrollTransition(topLeading: .animated, bottomTrailing: .interactive) { view, phase in
                            view.opacity(1 - (phase.value < 0 ? -phase.value : phase.value))
                        }
                }
            })
            .padding(.horizontal, 25)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    ScrollViewDemo5()
}
