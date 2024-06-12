//
//  AnyLayoutAnimationView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct AnyLayoutAnimationView: View {
    @State private var isShowPic: Bool = false
    var body: some View {
        let dynamicLayout = isShowPic ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
        dynamicLayout {
            Image("Pic")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .transition(.push(from: .trailing))
        
            Image("Pic")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Rectangle())
                .transition(.push(from: .trailing))
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowPic.toggle()
            }
        }
    }
}

struct AnyLayoutAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnyLayoutAnimationView()
    }
}
