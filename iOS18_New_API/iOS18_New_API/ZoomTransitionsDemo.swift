//
//  ZoomTransitionsDemo.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ZoomTransitionsDemo: View {
    @Namespace private var animation
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), alignment: .center) {
                ForEach(1...20, id: \.self) { index in
                    NavigationLink {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green.gradient)
                            .contentShape(.rect(cornerRadius: 20))
                            .ignoresSafeArea()
                            .navigationTitle("Detail View")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTransition(.zoom(sourceID: index, in: animation))
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green.gradient)
                            .frame(height: 150)
                            .contentShape(.rect(cornerRadius: 20))
                            .matchedTransitionSource(id: index, in: animation) { config in
                                config
                                    .background(.clear)
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(15)
        }
        .navigationTitle("Zoom Transitions")
    }
}

#Preview {
    NavigationStack {
        ZoomTransitionsDemo()
    }
}
