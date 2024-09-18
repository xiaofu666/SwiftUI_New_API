//
//  TransitionDemo.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2024/9/18.
//

import SwiftUI

struct TransitionDemo: View {
    @State private var showView: Bool = false
    
    var body: some View {
        ZStack {
            if showView {
                ExpandedView()
                    .transition(.blurReplace(.upUp).combined(with: .push(from: .top)))
            } else {
                MiniMisedView()
                    .transition(.blurReplace(.downUp).combined(with: .push(from: .bottom)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.fill)
    }
    
    @ViewBuilder
    func ExpandedView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Engraving")
                .font(.callout)
                .fontWeight(.semibold)
            
            Text("Add a message that lasts.")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Choose from new engraving options. It's the perfect way to personalise yourAirPods, Add a special message, name or birthday. Even combine text and numbers with your favourite emoji.")
                .font(.callout)
            
            Link("Learn More", destination: URL(string: "https://apple.com")!)
        }
        .frame(width: 250)
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.bouncy) {
                    showView.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
            }
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
        }
    }
    
    @ViewBuilder
    func MiniMisedView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(systemName: "face.smiling")
                .font(.title)
            
            Text("Personalise your AirPods for free.")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Engrave your new AirPods with a mix of emoji, names, initials and numbers.")
                .font(.callout)
            
            Button {
                withAnimation(.bouncy) {
                    showView.toggle()
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: 250)
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
        }
    }
}

#Preview {
    TransitionDemo()
}
