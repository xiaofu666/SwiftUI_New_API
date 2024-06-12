//
//  CustomContainerViews.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct CustomContainerViews: View {
    var body: some View {
        CustomView1 {
            ForEach(1...5, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .fill(.red.gradient)
                    .frame(height: 45)
            }
        }
        .padding(15)
        Divider()
        CustomView2 {
            ForEach(1...5, id: \.self) { index in
                Section {
                    Text("Content")
                } header: {
                    Text("Header")
                } footer: {
                    Text("Footer")
                }
            }
        }
        .padding(15)
    }
}

struct CustomView1<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 10) {
            Group(subviewsOf: content) { collection in
                ForEach(collection) { subview in
                    subview
                }
            }
        }
    }
}

struct CustomView2<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 10) {
            Group(sectionsOf: content) { collection in
                ForEach(collection) { section in
                    HStack {
                        section.header
                            .frame(maxWidth: .infinity)
                        
                        section.content
                            .frame(maxWidth: .infinity)
                        
                        section.footer
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

#Preview {
    CustomContainerViews()
}
