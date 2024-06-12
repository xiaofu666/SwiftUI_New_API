//
//  TabBarSheetView.swift
//  SwiftUI_iOS17_Demo
//
//  Created by Lurich on 2023/8/26.
//

import SwiftUI


struct TabBarSheetView: View {
    @Environment(WindowShareModel.self) private var windowShareModel
    @Environment(SceneDelegate.self) private var sceneDelegate
    
    var body: some View {
        @Bindable var bindShareModel = windowShareModel
        TabView(selection: $bindShareModel.activeTab) {
            NavigationStack {
                Text("People")
            }
            .tag(FindAPP_Tab.people)
            .hiddenTabBar()
            
            NavigationStack {
                Text("Devices")
            }
            .tag(FindAPP_Tab.devices)
            .hiddenTabBar()
            
            NavigationStack {
                Text("Items")
            }
            .tag(FindAPP_Tab.items)
            .hiddenTabBar()
            
            NavigationStack {
                Text("Me")
            }
            .tag(FindAPP_Tab.me)
            .hiddenTabBar()
        }
        .tabBarSheet(initialHeight: 110, sheetCornerRadius: 15) {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 15, content: {
                        if windowShareModel.activeTab == .devices {
                            DeviceRowView("iphone", "Lurich iPhone 12", "home")
                            DeviceRowView("ipad", "Lurich iPad 12.9", "home")
                            DeviceRowView("macbook", "Lurich Mac Book Pro 15", "home")
                            DeviceRowView("applewatch", "Lurich watch 8", "home")
                            DeviceRowView("airpods", "Lurich Airpods", "home")
                        }
                        if windowShareModel.activeTab == .devices {
                            DeviceRowView("ipod", "Lurich iPod", "home")
                            DeviceRowView("tv", "Lurich Apple TV", "home")
                            DeviceRowView("desktopcomputer", "Lurich iMac", "home")
                            DeviceRowView("pc", "Lurich Window PC", "home")
                            DeviceRowView("macmini", "Lurich Macmini", "home")
                            DeviceRowView("magicmouse", "Lurich Magicmouse", "home")
                            DeviceRowView("applepencil", "Lurich Apple Pencil", "home")
                        }
                    })
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(windowShareModel.activeTab.title)
                            .font(.title3.bold())
                    }
                    
                    if windowShareModel.activeTab == .devices {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                })
            }
        }
        .onAppear() {
            guard sceneDelegate.tabWindow == nil else { return }
            sceneDelegate.addTabBar(windowShareModel)
        }
    }
    
    @ViewBuilder
    func DeviceRowView(_ image: String, _ title: String, _ subTitle: String) -> some View {
        HStack(spacing: 12, content: {
            Image(systemName: image)
                .font(.title2)
                .padding(12)
                .background(.background, in: .circle)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(Int.random(in: 0...100)) km")
                .font(.callout)
                .foregroundStyle(.gray)
        })
    }
}



enum FindAPP_Tab: String, CaseIterable {
    case people = "figure.2.arms.open"
    case devices = "macbook.and.iphone"
    case items = "circle.grid.2x2.fill"
    case me = "person.circle.fil1"
    
    var title: String {
        switch self {
        case .people:
            return "people"
        case .devices:
            return "Devices"
        case .items:
            return "Items"
        case .me:
            return "Me"
        }
    }
}

fileprivate extension TabView {
    @ViewBuilder
    func tabBarSheet<SheetContent: View>(initialHeight: CGFloat = 100, sheetCornerRadius: CGFloat = 15, @ViewBuilder content: @escaping () -> SheetContent) -> some View {
        self
            .modifier(BottomSheetModifier(initialHeight: initialHeight, sheetContentRadius: sheetCornerRadius, sheetView: content()))
    }
}

fileprivate extension View {
    @ViewBuilder
    func hiddenTabBar() -> some View {
        self.toolbar(.hidden, for: .tabBar)
    }
}

fileprivate struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    var initialHeight: CGFloat
    var sheetContentRadius: CGFloat
    var sheetView: SheetContent
    @State private var showSheet: Bool = true
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet, content: {
                sheetView
                    .presentationDetents([.height(initialHeight), .medium, .fraction(0.99)])
                    .presentationCornerRadius(sheetContentRadius)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .presentationBackground(.regularMaterial)
                    .interactiveDismissDisabled()
            })
    }
}

struct CustomTabBar: View {
    @Environment(WindowShareModel.self) private var windowShareModel
    
    var body: some View {
        VStack(spacing: 0, content: {
            Divider()
            
            HStack(spacing: 0, content: {
                ForEach(FindAPP_Tab.allCases, id: \.rawValue) { tab in
                    Button(action: {
                        windowShareModel.activeTab = tab
                    }, label: {
                        Image(systemName: tab.rawValue)
                            .font(.title2)
                        
                        Text(tab.title)
                            .font(.caption)
                    })
                    .foregroundStyle(windowShareModel.activeTab == tab ? Color.accentColor : .gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                }
            })
            .frame(height: 55)
        })
        .background(.regularMaterial)
    }
}
