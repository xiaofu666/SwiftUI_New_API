//
//  ImageRendererView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ImageRendererView: View {
    
    @State private var currentImage: UIImage?
    
    var body: some View {
        VStack(spacing: 30) {
            TestView()
            
            Button("Convert Into Image") {
                let render = ImageRenderer(content: TestView())
                if let image = render.uiImage {
                    currentImage = image
                }
            }
            
            if let currentImage = currentImage {
                Image(uiImage: currentImage)
            }
        }
    }
    
    @ViewBuilder
    func TestView() -> some View {
        VStack {
            Image("Pic")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Pic")
                .fontWeight(.bold)
                .foregroundColor(.red)
        }
    }
}

struct ImageRendererView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRendererView()
    }
}
