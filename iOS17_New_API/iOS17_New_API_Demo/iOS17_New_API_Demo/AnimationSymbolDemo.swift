//
//  AnimationSymbolDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct AnimationSymbolDemo: View {
    var body: some View {
        VStack(spacing: 20) {
            AnimationSymbolDemo1()
            
            AnimationSymbolDemo2()
        }
    }
}

struct AnimationSymbolDemo1: View {
    @State private var isAnimation: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "suit.heart.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .symbolEffect(.pulse, options: .repeating, value: isAnimation)
                .onTapGesture {
                    isAnimation.toggle()
                }
            
            Image(systemName: "suit.heart.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .symbolEffect(.bounce, options: .repeating, value: isAnimation)
                .onTapGesture {
                    isAnimation.toggle()
                }
            
            Image(systemName: "suit.heart.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .symbolEffect(.variableColor, options: .repeating, value: isAnimation)
                .onTapGesture {
                    isAnimation.toggle()
                }
        }
    }
}

struct AnimationSymbolDemo2: View {
    @State private var startSwitching: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            PhaseAnimator(SFImage.allCases, trigger: startSwitching) { symbol in
                ZStack {
                    Circle()
                        .fill(symbol.color.gradient)
                    
                    Image(systemName: symbol.rawValue)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 100)
            } animation: { symbol in
                switch symbol {
                case .heart:
                    return .bouncy(duration: 1)
                case .house:
                    return .smooth(duration: 1)
                case .iphone:
                    return .snappy(duration: 1)
                }
            }

        }
        .onTapGesture {
            startSwitching.toggle()
        }
    }
}

enum SFImage: String, CaseIterable {
    case heart = "suit.heart.fill"
    case house = "house.fill"
    case iphone = "iphone"
    var color: Color {
        switch self {
        case .heart:
            return .red
        case .house:
            return .blue
        case .iphone:
            return .yellow
        }
    }
}

#Preview {
    AnimationSymbolDemo()
}
