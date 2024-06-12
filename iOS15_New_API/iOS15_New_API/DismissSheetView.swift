//
//  DismissSheetView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct DismissSheetView: View {
    @State private var isShowSheet = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                isShowSheet.toggle()
            }
        }
        .navigationTitle("详情页禁止手势返回")
        .sheet(isPresented: $isShowSheet) {
            Text("I'm is a sheet view")
                .interactiveDismissDisabled(true) //禁止手势滑动返回
                .onTapGesture {
                    isShowSheet.toggle()
                }
        }
    }
}

struct DismissSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DismissSheetView()
    }
}
