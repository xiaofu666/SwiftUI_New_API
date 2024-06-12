//
//  SafeAreaView.swift
//  iOS15_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct SafeAreaView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(1...20, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 45, height: 45, alignment: .center)
                        
                        VStack(alignment: .center) {
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 15)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 15)
                                .padding(.trailing, 50)
                        }
                    }
                }
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            Capsule()
                .fill(.red)
                .frame(height: 50)
                .padding()
        }
        .safeAreaInset(edge: .top) {
            Capsule()
                .fill(.red)
                .frame(height: 50)
                .padding()
        }
        .safeAreaInset(edge: .leading) {
            Capsule()
                .fill(.red)
                .frame(width: 50)
                .padding()
        }
        .safeAreaInset(edge: .trailing) {
            Capsule()
                .fill(.red)
                .frame(width: 50)
                .padding()
        }
    }
}

struct SafeAreaView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaView()
    }
}
