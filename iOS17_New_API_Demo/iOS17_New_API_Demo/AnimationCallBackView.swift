//
//  AnimationCallBackView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct AnimationCallBackView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            AnimationCallBackView1()
            
            AnimationCallBackView2()
        }
    }
}

struct AnimationCallBackView1: View {
    @State private var isShow: Bool = false
    
    var body: some View {
        VStack {
            if isShow {
                Text("Hello world!")
            }
            
            Button("Show View") {
                withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                    isShow.toggle()
                } completion: {
                    print("Completed But View Not Removed")
                }

            }
        }
    }
}

struct AnimationCallBackView2: View {
    @State private var value: Float = 0
    
    var body: some View {
        VStack {
            Button("Show Value") {
                value = 10
            }
        }
        .onChange(of: value, initial: true) { oldValue, newValue in
            print("oldValue = \(oldValue), newValue = \(newValue)")
        }
    }
}

#Preview {
    AnimationCallBackView()
}
