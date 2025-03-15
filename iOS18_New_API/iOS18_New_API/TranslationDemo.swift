//
//  TranslationDemo.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2025/3/15.
//

import SwiftUI
import Translation

struct TranslationDemo: View {
    @State private var showTranslation = false
    @State private var originalText = "Using Translation API in your App after iOS 17.4"
    // 翻译配置
    @State private var configuration: TranslationSession.Configuration?
    @State private var result: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text(originalText)
            
            HStack(spacing: 40) {
                VStack {
                    Text("方式1")
                    Button("Translate") {
                        showTranslation.toggle()
                    }
                }
                
                VStack {
                    Text("方式2")
                    Button {
                        // 汉翻英
                        configuration = TranslationSession.Configuration(source: .init(identifier: "en-US"), target: .init(identifier: "zh-Hans-CN"))
                    } label: {
                        Label("Translate", systemImage: "translate")
                            .labelStyle(.iconOnly)
                    }
                }
            }
            
            Text(result)
        }
        .padding()
        .translationPresentation(isPresented: $showTranslation, text: originalText) { translatedText in
            print(translatedText)
            originalText = translatedText
        }
        .translationTask(configuration) { session in
            // 翻译
            if let response = try? await session.translate(originalText) {
                result = response.targetText
            }
        }
    }
}

#Preview {
    TranslationDemo()
}
