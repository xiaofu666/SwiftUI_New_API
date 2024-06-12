//
//  BadgeView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct BadgeView: View {
    @State private var badge: Int = 10
    
    var body: some View {
        TabView {
            Text("Home View Click Me")
                .tabItem {
                    Label("首页", systemImage: "house")
                }
                .badge(badge)
                .onTapGesture {
                    badge = badge < 0 ? 0 : badge - 1
                }
            
            Text("Chat View")
                .tabItem {
                    Label("首页", systemImage: "suit.heart.fill")
                }
                .badge("")
            
            Text("Chat View")
                .tabItem {
                    Label("首页", systemImage: "gearshape")
                }
                .badge(0)
            
            Text("Setting View")
                .tabItem {
                    Label("首页", systemImage: "gear.circle")
                }
                .badge("new")
        }
        .tint(.green)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
