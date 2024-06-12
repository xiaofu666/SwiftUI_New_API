//
//  ScrollPhaseChange.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ScrollPhaseChange: View {
    private var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo, .teal, .pink, .mint, .brown, .black, .accentColor]
    @State private var isScrolling: Bool = false
    
    var body: some View {
        VStack {
            Text(isScrolling ? "Scrolling" : "Idle")
                .font(.title2.bold())
            
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color.gradient)
                            .frame(height: 220)
                    }
                }
                .padding(15)
            }
        }
        .onScrollPhaseChange { oldPhase, newPhase in
            isScrolling = newPhase.isScrolling
        }
    }
}

#Preview {
    ScrollPhaseChange()
}
