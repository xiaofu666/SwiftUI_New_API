//
//  NativeWebViewDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI
import WebKit

struct NativeWebViewDemo: View {
    @State private var page: WebPage = .init()
    
    var body: some View {
        WebView(page)
            .webViewMagnificationGestures(.disabled)
            .onAppear() {
                page.load(URLRequest(url: url))
            }
    }
    
    var url: URL {
        URL(string: "https://developer.apple.com")!
    }
}

#Preview {
    NativeWebViewDemo()
}
