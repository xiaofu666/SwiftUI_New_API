//
//  SwipeActionView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct SwipeActionView: View {
    @State private var result: [Int] = []
    var body: some View {
        List {
            ForEach(result, id: \.self) { index in
                Text("Content \(index)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            print("删除")
                            result.removeAll { num in
                                num == index
                            }
                        } label: {
                            Image(systemName: "trash.circle.fill")
                        }
                        .tint(.red)
                        
                        Button {
                            print("设置")
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button("添加") {
                            print("添加")
                            result.append(result.count)
                        }
                        .tint(.green)
                    }
            }
        }
        .onAppear() {
            for i in 0...20 {
                result.append(i)
            }
        }
        .navigationTitle("左滑右滑手势操作")
    }
}

struct SwipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionView()
    }
}
