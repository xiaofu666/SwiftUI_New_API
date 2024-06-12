//
//  SheetView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct SheetView: View {
    @State private var isPresent: Bool = false
    
    var body: some View {
        Button("Show Sheet") {
            isPresent.toggle()
        }
        .sheet(isPresented: $isPresent) {
            Text("Hello From Sheet")
                .presentationDetents([.small, .large, .medium])
//                .presentationDragIndicator(.hidden)//隐藏小横跳
        }
    }
}
extension PresentationDetent {
    static let small = Self.height(100)
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
