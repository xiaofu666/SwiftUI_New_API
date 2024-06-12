//
//  AppStorageView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("key") var value = "持久化存储"

    var body: some View {
        VStack {
            Text(value)
            
            Button("更改") {
                value += "➕1"
            }
            
            Text("\(UserDefaults.standard.object(forKey: "key") as? String ?? "")")
        }
        .navigationTitle("持久化存储")
    }
}

struct AppStorageView_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageView()
    }
}
