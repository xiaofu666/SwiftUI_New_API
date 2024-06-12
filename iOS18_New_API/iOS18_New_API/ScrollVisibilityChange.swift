//
//  ScrollVisibilityChange.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ScrollVisibilityChange: View {
    private var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo, .teal, .pink, .mint, .brown, .black, .accentColor]
    @State private var isScrolling: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color.gradient)
                        .containerRelativeFrame(.vertical)
                        // threshold -> top: 0, middle: 0.5, bottom: 1
                        .onScrollVisibilityChange(threshold: 0.5) { status in
                            if status {
                                print("\(color) is visible")
                            }
                        }
                }
            }
            .padding(15)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
    }
}

#Preview {
    ScrollVisibilityChange()
}
