//
//  ScrollPositionDemo.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ScrollPositionDemo: View {
    private var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo, .teal, .pink, .mint, .brown, .black, .accentColor]
    @State private var position: ScrollPosition = .init(idType: Color.self)
    
    var body: some View {
        VStack {
            Button("Moved") {
                withAnimation {
                    position.scrollTo(y: 550)
                }
            }
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color.gradient)
                            .frame(height: 220)
                    }
                }
                .padding(15)
                .scrollTargetLayout()
            }
            .scrollPosition($position)
        }
    }
}

#Preview {
    ScrollPositionDemo()
}
