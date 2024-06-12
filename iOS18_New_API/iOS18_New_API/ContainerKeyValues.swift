//
//  ContainerKeyValues.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct ContainerKeyValues: View {
    var body: some View {
        CustomView3 {
            ForEach(1...10, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue)
                    .containerValue(\.floatIndex, CGFloat(index))
            }
        }
        .padding(15)
    }
}
struct CustomView3<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 10) {
            Group(subviewsOf: content) { collection in
                ForEach(collection) { subView in
                    let index = subView.containerValues.floatIndex
                    
                    subView
                        .overlay {
                            Text("\(index)")
                        }
                }
            }
        }
    }
}
struct ViewKey: ContainerValueKey {
    static var defaultValue: CGFloat = 0.0
}
extension ContainerValues {
    var floatIndex: CGFloat {
        get {
            self[ViewKey.self]
        }
        set {
            self[ViewKey.self] = newValue
        }
    }
}

#Preview {
    ContainerKeyValues()
}
