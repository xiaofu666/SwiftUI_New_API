//
//  FoundationModelsDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI
import FoundationModels

struct FoundationModelsDemo: View {
    @State private var prompt: String = ""
    @State private var answer: String = ""
    @State private var disableControls: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                 Text(answer)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(15)
            }
            .safeAreaBar(edge: .bottom) {
                HStack(spacing: 10) {
                    TextField("Prompt", text: $prompt)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .glassEffect(.regular, in: .capsule)
                    
                    Button {
                        Task {
                            guard !prompt.isEmpty else { return }
                            do {
                                let session = LanguageModelSession()
                                disableControls = true
                                
                                // 一次性获得全部结果
//                                let answer = try await session.respond(to: prompt)
//                                self.answer = answer.content
                                
                                // 流式获取结果
                                let response = session.streamResponse(to: prompt)
                                for try await chunk in response {
                                    self.answer = chunk
                                }
                                
                                disableControls = false
                            } catch {
                                disableControls = false
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .frame(width:30, height:30)
                    }
                    .buttonStyle(.glass)
                    .disabled(disableControls)
                }
                .padding(15)
            }
            .navigationTitle("Foundation Model")
            // 去除导航栏软模糊效果
            .scrollEdgeEffectStyle(.hard, for: .top)
        }
    }
}

#Preview {
    FoundationModelsDemo()
}
