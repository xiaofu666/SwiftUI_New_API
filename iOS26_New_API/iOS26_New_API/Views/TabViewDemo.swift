//
//  TabViewDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct TabViewDemo: View {
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "house.fill") {
                ScrollView(.vertical) {
                    Text("Home")
                        .containerRelativeFrame([.horizontal])
                        .containerRelativeFrame(.vertical) { value, _ in
                            value * 2
                        }
                }
            }
            Tab.init("Favorite", systemImage: "suit.heart.fill") {
                Text("Favorites")
            }
            Tab.init("Settings", systemImage: "gearshape.fill") {
                Text("Settings")
            }
            Tab.init("Search", systemImage: "magnifyingglass", role: .search) {
                Text("Search")
                    .searchable(text: .constant(""))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .tabViewBottomAccessory {
            Text("Custom Mini Views")
                .padding(.horizontal, 15)
        }
//        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    TabViewDemo()
}
