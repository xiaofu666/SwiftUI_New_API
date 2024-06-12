//
//  UIKitGestureRepresentable.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct UIKitGestureRepresentable: View {
    @State private var offsetY: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Offset Y: \(offsetY)")
            
            ScrollView {
                VStack {
                    ForEach(1...20, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.purple.gradient)
                            .frame(height: 45)
                    }
                }
                .padding(15)
            }
            .gesture(SimultaneousGesture(offsetY: $offsetY))
        }
    }
}

#Preview {
    UIKitGestureRepresentable()
}


struct SimultaneousGesture: UIGestureRecognizerRepresentable {
    @Binding var offsetY: CGFloat
    
    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        return Coordinator()
    }
    
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = context.coordinator
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        let translation = recognizer.translation(in: recognizer.view)
        offsetY = translation.y
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
}
