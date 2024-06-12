//
//  iPad_NavigationSplitView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct iPad_NavigationSplitView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        iPad_NavigationSplitView()
    }
    
    @State private var visibility: NavigationSplitViewVisibility = .automatic
    @State private var typeInt: Int = 0
    @ViewBuilder
    func iPad_NavigationSplitView() -> some View {
        VStack {
            //针对iPad新增的
            NavigationSplitView(columnVisibility: $visibility) {
                Text("一级菜单")
                    .navigationSplitViewColumnWidth(120)
                    .onTapGesture {
                        dismiss()
                    }
            } content: {
                Text("二级菜单")
                    .navigationSplitViewColumnWidth(150)
            } detail: {
                Button("Show Bar") {
                    switch typeInt {
                    case 0:
                        visibility = .detailOnly
                    case 1:
                        visibility = .doubleColumn
                    case 2:
                        visibility = .all
                    default:
                        visibility = .automatic
                    }
                    typeInt = typeInt >= 2 ? 0 : typeInt + 1
                }
            }
            .navigationSplitViewStyle(.balanced)
            .navigationSplitViewColumnWidth(min: 100, ideal: 150, max: 200)
        }
    }
}

struct iPad_NavigationSplitView_Previews: PreviewProvider {
    static var previews: some View {
        iPad_NavigationSplitView()
    }
}
