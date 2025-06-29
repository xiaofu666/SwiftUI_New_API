//
//  ToolBarSpacerDemo.swift
//  iOS26_New_API
//
//  Created by Xiaofu666 on 2025/6/29.
//

import SwiftUI

struct ToolBarSpacerDemo: View {
    var body: some View {
        List {
            
        }
        .navigationTitle("Todo's")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button("", systemImage:"suit.heart.fill") {
                    }
                    Button("", systemImage: "magnifyingglass") {
                    }
                }
            }
            ToolbarSpacer(.fixed, placement: .topBarTrailing)
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button("", systemImage:"person.fill") {
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ToolBarSpacerDemo()
    }
}
