//
//  TransitionAnimationView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct TransitionAnimationView: View {
    @State private var isShowLogo: Bool = false
    
    var body: some View {
        VStack {
            if isShowLogo {
                Image("Pic")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .transition(.push(from: .trailing))
            } else {
                Image("Pic")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Rectangle())
                    .transition(.push(from: .trailing))
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowLogo.toggle()
            }
        }
    }
}

struct TransitionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionAnimationView()
    }
}
