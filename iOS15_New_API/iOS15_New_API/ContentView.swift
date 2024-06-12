//
//  ContentView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink("画布", destination: CanvasView())
                    
                    NavigationLink("持久化存储", destination: AppStorageView())
                    
                    NavigationLink("左右轻扫手势", destination: SwipeActionView())
                    
                    NavigationLink("禁止手势滑动返回", destination: DismissSheetView())
                    
                    NavigationLink("列表刷新", destination: ListViewRefresh())
                    
                    NavigationLink("异步加载图片", destination: AsyncImageView())
                    
                    NavigationLink("角标", destination: BadgeView())
                    
                    NavigationLink("安全区域", destination: SafeAreaView())
                    
                    NavigationLink("文本提交", destination: TextfieldSubmit())
                }
            }
            .navigationTitle("iOS15 New API")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
