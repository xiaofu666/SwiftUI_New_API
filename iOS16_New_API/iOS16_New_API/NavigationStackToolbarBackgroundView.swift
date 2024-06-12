//
//  NavigationStackToolbarBackgroundView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct NavigationStackToolbarBackgroundView: View {
    var body: some View {
        VStack {
            Text("Hello")
        }
        .navigationTitle("Title")
        .toolbarBackground(Color.yellow, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbar(.hidden, for: .navigationBar)// 隐藏导航栏
    }
}

struct NavigationStackToolbarBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackToolbarBackgroundView()
    }
}
