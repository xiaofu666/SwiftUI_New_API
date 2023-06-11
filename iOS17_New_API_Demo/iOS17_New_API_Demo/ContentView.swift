//
//  ContentView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Group {
                        NavigationLink("Swift Data", destination: SwiftDataDemo().modelContainer(for: Person.self))
                        
                        NavigationLink("Scroll View", destination: ScrollViewDemo())
                        
                        NavigationLink("Scroll View 滚动定位", destination: ScrollViewDemo4())
                        
                        NavigationLink("Scroll View Transition", destination: ScrollViewDemo5())
                        
                        NavigationLink("Custom Transition", destination: CustomTransitionView())
                        
                        NavigationLink("Animation Callback", destination: AnimationCallBackView())
                        
                        NavigationLink("Observable & Bindable", destination: ObservableAndBindableDemo())
                        
                        NavigationLink("UnevenRoundedRectangle", destination: UnevenRoundedRectangleDemo())
                    }
                    
                    Group {
                        NavigationLink("FeedBack", destination: FeedBackDemo())
                        
                        NavigationLink("VisualEffect", destination: VisualEffectDemo())
                        
                        NavigationLink("AnimationSymbol", destination: AnimationSymbolDemo())
                        
                        NavigationLink("Keyframe Animation", destination: KeyframeAnimationDemo())
                        
                        NavigationLink("Maps", destination: MapDemoView())
                    }
                }
            }
            .navigationTitle("iOS 17 New API")
        }
    }
}

#Preview {
    ContentView()
}
