//
//  DownsizedImageView.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2025/1/7.
//

import SwiftUI

struct DownsizedImageDemo: View {
    var body: some View {
        let size: CGSize = .init(width: 150, height: 200)
        DownsizedImageView(image: UIImage(named: "testImg"), size: size) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
        }
    }
}

struct DownsizedImageView<Content: View>: View {
    var image: UIImage?
    var size: CGSize
    @ViewBuilder var content: (Image) -> Content
    
    @State private var downsizedImage: Image?
    
    var body: some View {
        ZStack {
            if let downsizedImage {
                content(downsizedImage)
            }
        }
        .onAppear {
            guard downsizedImage == nil else { return }
            createDownsizedImage(image)
        }
        .onChange(of: image) { oldValue, newValue in
            guard oldValue != newValue else { return }
            createDownsizedImage(newValue)
        }
    }
    
    private func createDownsizedImage(_ image: UIImage?) {
        guard let image else { return }
        let aspectSize = image.size.aspectFit(size)
        Task.detached(priority: .high) {
            let render = UIGraphicsImageRenderer(size: aspectSize)
            let resizedImage = render.image { ctx in
                image.draw(in: .init(origin: .zero, size: aspectSize))
            }
            await MainActor.run {
                downsizedImage = .init(uiImage: resizedImage)
            }
        }
    }
}

extension CGSize {
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / self.width
        let scaleY = to.height / self.height
        
        let aspectRatio = min(scaleX, scaleY)
        return .init(width: aspectRatio * width, height: aspectRatio * height)
    }
}

#Preview {
    DownsizedImageDemo()
}
