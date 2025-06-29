//
//  BackgroundExtensionEffectDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct BackgroundExtensionEffectDemo: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            Image(.pic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                .backgroundExtensionEffect()
        }
    }
}

#Preview {
    BackgroundExtensionEffectDemo()
}
