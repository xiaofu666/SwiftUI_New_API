//
//  RichTextEditorDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct RichTextEditorDemo: View {
    @State private var richText: AttributedString = .init()
    
    var body: some View {
        TextEditor(text: $richText)
            .frame(height: 300)
            .padding(15)
    }
}

#Preview {
    RichTextEditorDemo()
}
