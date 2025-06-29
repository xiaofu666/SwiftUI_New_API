//
//  LiquidGlassEffectView.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct LiquidGlassEffectView: View {
    var body: some View {
        ZStack {
            Image(.pic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(.rect(cornerRadius: 20, style: .continuous))
            
            Button("Tap Me") {
                
            }
            .buttonStyle(.glass)
            .offset(y: 50)
            
            Image(systemName: "suit.heart.fill")
                .font(.largeTitle)
                .foregroundStyle(.red.gradient)
                .frame(width: 50, height: 50)
                .glassEffect(.regular.tint(.red.opacity(0.35)).interactive(), in: .circle)
                .offset(y: -50)
        }
    }
}

#Preview {
    LiquidGlassEffectView()
}
