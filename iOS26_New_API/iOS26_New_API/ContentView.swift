//
//  ContentView.swift
//  iOS26_New_API
//
//  Created by Lurich on 2025/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Group {
                        NavigationLink("玻璃液化效果", destination: NewSymbolEffects())
                    }
                }
            }
            .navigationTitle("iOS 18 New API")
        }
    }
}


#Preview {
    ContentView()
}
