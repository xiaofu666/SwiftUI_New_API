//
//  ObservableAndBindableDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI
import SwiftData

struct ObservableAndBindableDemo: View {
    @Bindable private var user: User = .init()
    
    var body: some View {
        VStack {
            TextField("请填写姓名", text: $user.name)
        }
        .onChange(of: user.name, initial: true) { oldValue, newValue in
            print("oldValue = \(oldValue), newValue = \(newValue)")
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ObservableAndBindableDemo()
}

@Observable
class User {
    var name = ""
    var age = 0
}
