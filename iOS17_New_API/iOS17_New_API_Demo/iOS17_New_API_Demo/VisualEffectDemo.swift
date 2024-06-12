//
//  VisualEffectDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct VisualEffectDemo: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20, content: {
                Rectangle()
                    .fill(.red.gradient)
                    .frame(height: 100)
                    .visualEffect { view, proxy in
                        view
                            .offset(y: proxy.bounds(of: .scrollView)?.minY ?? 0)
                    }
                    .zIndex(100)
                
                ForEach(1...30, id: \.self) { count in
                    Rectangle()
                        .fill(.blue.gradient)
                        .frame(height: 80)
                }
                .padding(.horizontal, 20)
            })
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    VisualEffectDemo()
}
