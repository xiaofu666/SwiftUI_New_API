//
//  ContentView.swift
//  SwiftUI_iOS17_Beta7_Demo
//
//  Created by Lurich on 2023/6/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Group {
                    }
                    
                    Group {
                        
                        FullScreenLink("头像转场动画-Navigation版本", destination:NavigationHeroAnimationView())
                        
                        FullScreenLink("头像转场动画-Present版本", destination:PresentHeroAnimationView())
                    }
                    
                    Group {
                        
                        FullScreenLink("查找 APP UI 模拟", destination:TabBarSheetView())
                    }
                    
                }
            }
        }
    }
}

struct FullScreenLink<Content: View>: View {
    @State var isPresent = false
    @Environment(\.colorScheme) var style
    var title: String
    var content: Content
    
    init(_ title: String, destination: Content) {
        self.title = title
        self.content = destination
    }
    var body: some View {
        HStack {
            Button {
                isPresent = true
            } label: {
                Text(title)
                    .foregroundColor(style == .dark ? .white : .black)
            }
            .fullScreenCover(isPresented: $isPresent) {
                self.content
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.callout.bold())
                .foregroundColor(.gray)
        }
    }
}


#Preview {
    ContentView()
}
