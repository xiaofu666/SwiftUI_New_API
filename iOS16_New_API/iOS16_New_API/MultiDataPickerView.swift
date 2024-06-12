//
//  MultiDataPickerView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct MultiDataPickerView: View {
    @State private var selectSet: Set<DateComponents> = []
    
    var body: some View {
        VStack {
            MultiDatePicker("多选日期", selection: $selectSet)
                .frame(height: 400)
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        // MARK: - 分为 inner 内嵌 和 drop 外扩
                        .fill(.gray.opacity(0.2).shadow(.drop(radius: 5)))
                }
                .padding()
        }
    }
}

struct MultiDataPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDataPickerView()
    }
}
