//
//  ContentView.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Group {
                        NavigationLink("导航转场", destination: ZoomTransitionsDemo())
                        
                        NavigationLink("Group SubView 获取", destination: CustomContainerViews())
                        
                        NavigationLink("UIKit 手势获取", destination: UIKitGestureRepresentable())
                        
                        NavigationLink("ContainerKey/Values", destination: ContainerKeyValues())
                        
                        NavigationLink("获取 ScrollView 偏移量", destination: ScrollGeometryChange())
                        
                        NavigationLink("获取 ScrollView 滚动状态", destination: ScrollPhaseChange())
                        
                        NavigationLink("获取 ScrollView 是否可见状态", destination: ScrollVisibilityChange())
                        
                        NavigationLink("ScrollView Position", destination: ScrollPositionDemo())
                        
                        NavigationLink("新符号效果", destination: NewSymbolEffects())
                    }
                    
                    Group {
                        NavigationLink("网格渐变色", destination: MeshGradientDemo())
                        
                        NavigationLink("iPad导航栏", destination: FloatingTabBar())
                        
                        NavigationLink("TextSelection", destination: TextSelectionAPI())
                        
                        NavigationLink("MoreTabBarHidden", destination: MoreTabBarHidden())
                        
                        NavigationLink("PhaseAnimatorDemo", destination: PhaseAnimatorDemo())
                        
                        NavigationLink("TransitionDemo", destination: TransitionDemo())
                        
                        NavigationLink("KeyframeAnimatorDemo", destination: KeyframeAnimatorDemo())
                    }
                }
            }
            .navigationTitle("iOS 18 New API")
        }
    }
}

#Preview {
    ContentView()
}
