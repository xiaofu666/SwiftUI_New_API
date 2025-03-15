//
//  PencilKitDemo.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2025/3/15.
//

import SwiftUI
import PencilKit

struct PencilKitDemo: View {
    @State private var reset: Bool = false
    var body: some View {
        ZStack {
//            Image(.testImg)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            
            if !reset {
                GeometryReader { _ in
                    CustomCanvasView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    reset = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        reset = false
                    }
                } label: {
                    Image(systemName: "trash.circle.fill")
                }
            }
        }
    }
}

fileprivate struct CustomCanvasView: UIViewRepresentable {
    @State private var toolPicker: PKToolPicker?
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView(frame: .zero)
        canvasView.backgroundColor = .clear
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //  iOS18新增，自定义调色板工具选项
            var config = PKToolPickerCustomItem.Configuration(identifier: "customTool", name: "pencil.and.scribble")
            config.imageProvider = { toolItem in
                guard let toolImage = UIImage(systemName: config.name) else {
                    return UIImage()
                }
                return toolImage
            }
            config.allowsColorSelection = true
            config.defaultColor = .black
            config.defaultWidth = 5.0
            let customItem = PKToolPickerCustomItem(configuration: config)
            // iOS18新增，自定义中间区域的调色板工具
            let toolPicker = PKToolPicker(
                toolItems: [
                    PKToolPickerInkingItem(
                        type: .pen
                    ),
                    PKToolPickerLassoItem(),
                    PKToolPickerRulerItem(),
                    PKToolPickerEraserItem(
                        type: .bitmap
                    ),
                    PKToolPickerInkingItem(
                        type: .pencil
                    ),
                    PKToolPickerInkingItem(
                        type: .marker
                    ),
                    PKToolPickerInkingItem(
                        type: .monoline
                    ),
                    PKToolPickerInkingItem(
                        type: .fountainPen
                    ),
                    PKToolPickerInkingItem(
                        type: .watercolor
                    ),
                    PKToolPickerInkingItem(
                        type: .crayon
                    ),
                    PKToolPickerScribbleItem(),
                    customItem
                ]
            )
            toolPicker.addObserver(canvasView)
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            // iOS18新增，自定义右侧附加选项
            toolPicker.accessoryItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), primaryAction: UIAction(handler: { _ in
                let drawing = canvasView.drawing
                let image = drawing.image(from: canvasView.frame, scale: UIScreen.main.scale)
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }))
            self.toolPicker = toolPicker
        }
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.becomeFirstResponder()
    }
}

#Preview {
    PencilKitDemo()
}
