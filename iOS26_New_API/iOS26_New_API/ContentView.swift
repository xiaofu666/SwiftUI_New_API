//
//  ContentView.swift
//  iOS26_New_API
//
//  Created by Lurich on 2025/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
#if os(iOS)
                Section {
                    Group {
                        NavigationLink("玻璃液化效果", destination: LiquidGlassEffectView())
                        
                        NavigationLink("玻璃效果容器", destination: GlassEffectContainerView())
                        
                        NavigationLink("Apple本地智能", destination: FoundationModelsDemo())
                        
                        NavigationLink("AI生成模型数据", destination: GenerableDemo())
                        
                        NavigationLink("背景扩展效果", destination: BackgroundExtensionEffectDemo())
                        
                        NavigationLink("富文本编辑器", destination: RichTextEditorDemo())
                        
                        NavigationLink("原生WebView", destination: NativeWebViewDemo())
                        
                        NavigationLink("新版TabView", destination: TabViewDemo())
                        
                        NavigationLink("工具栏项分离", destination: ToolBarSpacerDemo())
                        
                        NavigationLink("动画", destination: AnimatableDemo())
                        
                        NavigationLink("新增符号效果", destination: SymbolEffectsDemo())
                    }
                }
#endif // os(iOS)
                
#if os(macOS)
                Section {
                    // 运行于Mac
                    NavigationLink("多元素拖拽", destination: DraggableDemo())
                }
#endif // os(macOS)
            }
            .navigationTitle("iOS 26 New API")
        }
    }
}


#Preview {
    ContentView()
}
