//
//  AsyncImageView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://img1.baidu.com/it/u=1651692105,3554858566&fm=253&fmt=auto&app=138&f=JPG?w=889&h=500")!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
//                        .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20)) //添加模糊效果
                } else {
//                        print(phase.error)
                    ProgressView()
                }
            }
        }
        .padding()
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
