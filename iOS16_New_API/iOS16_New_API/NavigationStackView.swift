//
//  NavigationStackView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct NavigationStackView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStackView()
    }
    
    @State private var stack = NavigationPath()
    @ViewBuilder
    func NavigationStackView() -> some View {
        NavigationStack(path: $stack) {
            VStack {
                NavigationLink("Push Detail", value: 20)
                    .navigationDestination(for: Int.self) { value in
                        VStack(spacing: 30) {
                            NavigationLink("Push Detail", value: 30)
                            Text("\(value) View")
                            Button("back") {
                                /*
                                 //删除最后一个元素代表返回上一页
                                 stack.removeLast()
                                 //创建全新的path代表返回首页
                                 stack = .init()
                                 */
                                stack = .init()
                            }
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NavigationStackView2: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStackView2()
    }
    
    @State private var arrayPath: [Color] = []
    @ViewBuilder
    func NavigationStackView2() -> some View {
        NavigationStack(path: $arrayPath) {
            let colors: [Color] = [.pink, .teal]
            List(colors, id: \.self) { color in
                NavigationLink(color.description, value: color)
            }
            .navigationDestination(for: Color.self) { value in
                    VStack(spacing: 20) {
                        Text("Detail View")
                        
                        Button("Pop To RootView") {
                            arrayPath.removeAll()
                        }
                        
                        switch value {
                        case .pink:
                            Button("Push teal") {
                                arrayPath.append(.teal)
                            }
                        case .teal:
                            Button("Push mint") {
                                arrayPath.append(.pink)
                            }
                        default:
                            VStack {
                                
                            }
                        }
                    }
                    .background {
                        value
                    }
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NavigationStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackView()
    }
}
