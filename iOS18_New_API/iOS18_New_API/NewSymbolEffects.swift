//
//  NewSymbolEffects.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/6/12.
//

import SwiftUI

struct NewSymbolEffects: View {
    @State private var trigger1: Bool = false
    @State private var trigger2: Bool = false
    @State private var trigger3: Bool = false
    
    @State private var trigger4: Bool = false
    @State private var trigger5: Bool = false
    @State private var trigger6: Bool = false
    @State private var trigger7: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("iOS 18 新增")
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.wiggle, value: trigger1)
                    .onTapGesture {
                        trigger1.toggle()
                    }
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.breathe, value: trigger2)
                    .onTapGesture {
                        trigger2.toggle()
                    }
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.rotate, value: trigger3)
                    .onTapGesture {
                        trigger3.toggle()
                    }
            }
            
            Divider()
                .padding(.vertical, 20)
            
            VStack(spacing: 20) {
                Text("iOS 17 的")
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.pulse, value: trigger4)
                    .onTapGesture {
                        trigger4.toggle()
                    }
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.bounce, value: trigger5)
                    .onTapGesture {
                        trigger5.toggle()
                    }
                
                Image(systemName: "gearshape")
                    .font(.system(size: 100))
                    .symbolEffect(.variableColor, value: trigger6)
                    .onTapGesture {
                        trigger6.toggle()
                    }
            }
        }
    }
}

#Preview {
    NewSymbolEffects()
}
