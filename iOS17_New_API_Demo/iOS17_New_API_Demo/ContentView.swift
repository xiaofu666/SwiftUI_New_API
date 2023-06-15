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
                        
                        NavigationLink("滚动视图头尾动画", destination: ScrollViewDemo5())
                        
                        NavigationLink("自定义转场动画", destination: CustomTransitionView())
                        
                        NavigationLink("动画结束回调", destination: AnimationCallBackView())
                        
                        NavigationLink("可观测的与可绑定的", destination: ObservableAndBindableDemo())
                        
                        NavigationLink("不均匀圆角矩形", destination: UnevenRoundedRectangleDemo())
                    }
                    
                    Group {
                        NavigationLink("反馈", destination: FeedBackDemo())
                        
                        NavigationLink("视觉效果", destination: VisualEffectDemo())
                        
                        NavigationLink("图标动画", destination: AnimationSymbolDemo())
                        
                        NavigationLink("关键帧动画", destination: KeyframeAnimationDemo())
                        
                        NavigationLink("地图", destination: MapDemoView())
                        
                        NavigationLink("图表", destination: InteractiveChartsView())
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
