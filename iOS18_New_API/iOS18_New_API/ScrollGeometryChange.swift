//
//  ScrollGeometryChange.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ScrollGeometryChange2: View {
    private var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo, .teal, .pink, .mint, .brown, .black, .accentColor]
    @State private var offsetY: CGFloat = .zero
    
    var body: some View {
        VStack {
            Text("ScrollView OffsetY: \(offsetY)")
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
        .onScrollGeometryChange(for: CGFloat.self) { proxy in
            return proxy.contentOffset.y
        } action: { oldValue, newValue in
            offsetY = newValue
        }
    }
}

struct ScrollGeometryChange: View {
    private var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo, .teal, .pink, .mint, .brown, .black, .accentColor]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color.gradient)
                        .frame(height: 220)
                }
            }
            .padding(15)
        }
        .onScrollGeometryChange(for: Bool.self) { proxy in
            return proxy.contentOffset.y > 200
        } action: { oldValue, newValue in
            if newValue {
                print("First Card Moved Away")
            }
        }
    }
}

#Preview {
    ScrollGeometryChange()
}
