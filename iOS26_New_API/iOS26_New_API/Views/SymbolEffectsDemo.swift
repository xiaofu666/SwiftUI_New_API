//
//  SymbolEffectsDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct SymbolEffectsDemo: View {
    @State private var isActive1: Bool = false
    @State private var isActive2: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName:"square.and.arrow.up")
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .symbolEffect(.drawOn, isActive: isActive1)
                .onTapGesture {
                    isActive1.toggle()
                }
            
            Image(systemName:"square.and.arrow.down")
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .symbolEffect(.drawOff, isActive: isActive2)
                .onTapGesture {
                    isActive2.toggle()
                }
        }
    }
}

#Preview {
    SymbolEffectsDemo()
}
