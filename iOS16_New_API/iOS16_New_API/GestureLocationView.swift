//
//  GestureLocationView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct GestureLocationView: View {
    @State private var localText: String = "相对于当前视图"
    @State private var globalText: String = "相对于全局视图"
    
    var body: some View {
        VStack(spacing: 30) {
            Rectangle()
                .fill(.red)
                .frame(height: 200)
                .onTapGesture { location in
                    print(location)
                    localText = "相对于当前视图" + "\(location)"
                }
                .overlay {
                    Text(localText)
                }
            
            Rectangle()
                .fill(.green)
                .frame(height: 200)
                .onTapGesture(coordinateSpace: .global) { location in
                    print(location)
                    globalText = "相对于全局视图" + "\(location)"
                }
                .overlay {
                    Text(globalText)
                }
        }
    }
}

struct GestureLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GestureLocationView()
    }
}
