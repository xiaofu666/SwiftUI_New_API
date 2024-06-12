//
//  UnevenRoundedRectangleDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct UnevenRoundedRectangleDemo: View {
    var body: some View {
        VStack(spacing: 30, content: {
            Text("方式一")
            UnevenRoundedRectangle(topLeadingRadius: 35, bottomTrailingRadius: 35)
                .fill(.red.gradient)
                .frame(width: 200, height: 200)
            Text("方式二")
            Rectangle()
                .fill(.red.gradient)
                .frame(width: 200, height: 200)
                .clipShape(.rect(topLeadingRadius: 35, bottomTrailingRadius: 35))
        })
    }
}

#Preview {
    UnevenRoundedRectangleDemo()
}
