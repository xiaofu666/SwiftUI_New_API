//
//  GlassEffectContainerView.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct GlassEffectContainerView: View {
    @State private var isExpanded: Bool = false
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            Image(.pic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                .overlay(alignment: .bottom) {
                    GlassEffectContainer(spacing: 20) {
                        VStack(spacing: 20) {
                            Spacer()
                            
                            if isExpanded {
                                Group {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "suit.heart.fill")
                                            .font(.title)
                                            .foregroundStyle(.red.gradient)
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title)
                                            .foregroundStyle(.white.gradient)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                .glassEffect(.regular, in: .circle)
                                // 消除变形动画
//                                .glassEffectTransition(.identity)
                            } else {
                                Group {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "suit.heart.fill")
                                            .font(.title)
                                            .foregroundStyle(.red.gradient)
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title)
                                            .foregroundStyle(.white.gradient)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                .glassEffect(.regular, in: .capsule)
                                .glassEffectUnion(id: "Group-2", namespace: animation)
                            }
                            
                            Button {
                                withAnimation(.smooth(duration: 1.0)) {
                                    isExpanded.toggle()
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title)
                                    .foregroundStyle(.white.gradient)
                                    .frame(width: 40, height: 40)
                            }
                            .buttonStyle(.glass)
                        }
                        .padding(15)
                    }
                }
        }
    }
}

#Preview {
    GlassEffectContainerView()
}
