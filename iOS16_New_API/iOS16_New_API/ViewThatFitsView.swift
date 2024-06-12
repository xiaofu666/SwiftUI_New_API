//
//  ViewThatFitsView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ViewThatFitsView: View {
    var body: some View {
        ViewThatFitsTestView()
    }
    //自动返回适合的 view
    @ViewBuilder
    func ViewThatFitsView() -> some View {
        ViewThatFits {
            HStack {
                Rectangle()
                    .frame(width: 100, height: 10)
                
                Text("Bar")
            }
            
            Rectangle()
                .frame(width: 80, height: 10)
            
            Text("Tool")
        }
    }
    
    @ViewBuilder
    func ViewThatFitsTestView() -> some View {
        VStack(alignment: .leading) {
            ViewThatFitsView()
                .frame(width: 50)
            ViewThatFitsView()
                .frame(width: 200)
            ViewThatFitsView()
                .frame(width: 100)
        }
    }
}

struct ViewThatFitsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewThatFitsView()
    }
}
