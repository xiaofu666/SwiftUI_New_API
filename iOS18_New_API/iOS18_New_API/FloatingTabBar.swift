//
//  FloatingTabBar.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/17.
//

import SwiftUI

struct FloatingTabBar: View {
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "house.fill"){
            }
            Tab.init("Search", systemImage: "magnifyingglass", role: .search){
            }
            Tab.init("Notifications", systemImage: "bell.fill"){
            }
            Tab.init("Settings", systemImage: "gearshape"){
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview("iPad 预览") {
    FloatingTabBar()
}
