//
//  ContentTransitionAnimationView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ContentTransitionAnimationView: View {
    @State private var isContentTransition: Bool = true
    @State private var number: Int = 100
    var body: some View {
        Text("Click Me")
            .font(isContentTransition ? .largeTitle : .caption2)
            .fontWeight(isContentTransition ? .black : .ultraLight)
            .foregroundColor(isContentTransition ? .green : .blue)
            .contentTransition(.interpolate)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    isContentTransition.toggle()
                }
            }
        
        
        Text("\(number)")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
            .contentTransition(.numericText(countsDown: true))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    number -= 1
                }
            }
            .padding(20)
    }
}

struct ContentTransitionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTransitionAnimationView()
    }
}
