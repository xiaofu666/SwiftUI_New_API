//
//  GestureIssue.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2024/11/18.
//

import SwiftUI

struct GestureIssue: View {
    @State private var isScrollDisabled: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Volume")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                Text(isScrollDisabled ? "Scroll-Disabled" : "Enabled")
                
                VolumeSlider(isScrollDisabled: $isScrollDisabled)
            }
            .padding()
        }
        .scrollDisabled(isScrollDisabled)
        .navigationTitle("Gesture - iOS 18")
    }
}

struct VolumeSlider: View {
    @Binding var isScrollDisabled: Bool
    @State private var progress: CGFloat = .zero
    @State private var lastProgress: CGFloat = .zero
    @State private var velocity: CGSize = .zero
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: progress * size.width)
            }
            .clipShape(.rect(cornerRadius: 10))
            .simultaneousGesture(
                CustomGesture
                    .onChanged({ value in
                        if #available(iOS 18, *) {
                            if velocity == .zero {
                                velocity = value.velocity
                            }
                            guard velocity.height == .zero else { return }
                            isScrollDisabled = true
                        }
                        let progress = value.translation.width / size.width + lastProgress
                        self.progress = max(min(progress, 1.0), 0.0)
                    })
                    .onEnded({ value in
                        lastProgress = progress
                        if #available(iOS 18, *) {
                            velocity = .zero
                            isScrollDisabled = false
                        }
                    })
            )
        }
        .frame(height: 40)
    }
    
    var CustomGesture: DragGesture {
        if #available(iOS 18, *) {
            DragGesture(minimumDistance: 1)
        } else {
            DragGesture()
        }
    }
}

#Preview {
    GestureIssue()
}
