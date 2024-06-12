//
//  TextfieldSubmit.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct TextfieldSubmit: View {
    @State private var textInput = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text("OnTrigger")
            
            TextField("请输入", text: $textInput)
                .textFieldStyle(.roundedBorder)
                .textContentType(.URL)
                .submitLabel(.done)
        }
        .padding()
        .searchable(text: $textInput)
        .navigationTitle("首页")
        .onSubmit(of: [.search, .text]) {
            print("内容 \(textInput)")
        }
    }
}

struct TextfieldSubmit_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldSubmit()
    }
}
