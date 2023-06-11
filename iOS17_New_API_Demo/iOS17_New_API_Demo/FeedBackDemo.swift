//
//  FeedBackDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI

struct FeedBackDemo: View {
    @State private var feedBack: Bool = false
    var body: some View {
        Button("Send FeedBack") {
            feedBack.toggle()
        }
        .sensoryFeedback(.warning, trigger: feedBack)
    }
}

#Preview {
    FeedBackDemo()
}
