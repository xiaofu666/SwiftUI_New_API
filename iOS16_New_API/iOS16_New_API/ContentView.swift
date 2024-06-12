//
//  ContentView.swift
//  iOS16_New_API
//
//  Created by Lurich on 2023/6/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Group {
                        NavigationLink("iOS 图表", destination: ChartView())
                        
                        NavigationLink("iOS 图表2", destination: ChartView2())
                        
                        NavigationLink("SheetView", destination: SheetView())
                        
                        NavigationLink("ShareLinkView", destination: ShareLinkView())
                        
                        NavigationLink("ViewThatFitsView", destination: ViewThatFitsView())
                        
                        NavigationLink("视图复制", destination: ImageRendererView())
                        
                        NavigationLink("获取点击坐标", destination: GestureLocationView())
                        
                        NavigationLink("ScrollView支持刷新", destination: ScrollViewAdd())
                    }
                    
                    Group {
                        FullScreenLink("导航栏1", destination: NavigationStackView())
                        
                        FullScreenLink("导航栏2", destination: NavigationStackView2())
                        
                        NavigationLink("网格视图", destination: GridView())
                        
                        NavigationLink("仪表视图", destination: GaugeView())
                        
                        NavigationLink("自定义StackView", destination: CustomStackView())
                    }
                    
                    Group {
                        FullScreenLink("iPad_NavigationSplitView", destination: iPad_NavigationSplitView())
                        
                        NavigationLink("iPad_TableView", destination: iPad_TableView())
                        
                        NavigationLink("iPad_TipTable", destination: iPad_TipTable())
                    }
                    
                    Group {
                        NavigationLink("过渡动画", destination: TransitionAnimationView())
                        
                        NavigationLink("时间选择", destination: MultiDataPickerView())
                        
                        NavigationLink("照片选择", destination: PhotoPickerView())
                        
                        NavigationLink("布局动画", destination: AnyLayoutAnimationView())
                        
                        NavigationLink("内容转场动画", destination: ContentTransitionAnimationView())
                        
                        NavigationLink("修改导航栏背景色", destination: NavigationStackToolbarBackgroundView())
                        
                        NavigationLink("列表刷新", destination: ListViewRefresh())
                    }
                }
            }
            .navigationTitle("iOS 16 New Api")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FullScreenLink<Content: View>: View {
    @State var isPresent = false
    @Environment(\.colorScheme) var style
    var title: String
    var content: Content
    
    init(_ title: String, destination: Content) {
        self.title = title
        self.content = destination
    }
    var body: some View {
        HStack {
            Button {
                isPresent = true
            } label: {
                Text(title)
                    .foregroundColor(style == .dark ? .white : .black)
            }
            .fullScreenCover(isPresented: $isPresent) {
                self.content
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.callout.bold())
                .foregroundColor(.gray)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
