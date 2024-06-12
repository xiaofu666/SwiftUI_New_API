//
//  ScrollViewAdd.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ScrollViewAdd: View {
    @State private var text: String = ""
    @State private var disable: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("标题", text: $text)
                
                ForEach(1...20, id: \.self) { _ in
                    Rectangle()
                        .fill(.red)
                        .frame(height: 200)
                }
            }
        }
        .refreshable {
            // 支持刷新了
        }
        //包括 立即 交互式 从不三种
        .scrollDismissesKeyboard(.interactively)
        .disabled(disable)
//        .onTapGesture {
//            disable.toggle()
//        }
    }
}

struct ScrollViewAdd_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewAdd()
    }
}
