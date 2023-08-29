//
//  ChangeAnimationView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/8/29.
//

import SwiftUI

struct ChangeAnimationView: View {
    @State private var text: Int = 0
    @State private var sfImage: String = "house.fill"
    @State private var sfCount: Int = 1
    
    var body: some View {
        VStack {
            Image(systemName: sfImage)
                .font(.largeTitle.bold())
                .contentTransition(.symbolEffect(.automatic))
                .frame(width: 50, height: 50)
            
            Button(action: {
                let images = ["house.fill", "square.and.arrow.up.fill", "trash.fill", "folder.fill", "tray.fill"]
                withAnimation(.bouncy) {
                    sfCount += 1
                    sfImage = images[sfCount % images.count]
                }
            }, label: {
                Text("Change Image")
            })
            .buttonStyle(.borderedProminent)
            .padding()
            
            Text("$\(text)")
                .font(.largeTitle.bold())
                .contentTransition(.numericText(value: Double(text)))
            
            Button(action: {
                withAnimation(.bouncy) {
                    text = Int.random(in: 100...10000)
                }
            }, label: {
                Text("Update")
            })
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding(15)
    }
}

#Preview {
    ChangeAnimationView()
}
