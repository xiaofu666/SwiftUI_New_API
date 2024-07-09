//
//  MoreTabBarHidden.swift
//  iOS18_New_API
//
//  Created by Lurich on 2024/7/8.
//

import SwiftUI

enum TabModel: String, CaseIterable {
    case home = "house.fill"
    case search = "magnifyingglass"
    case notifications = "bell.fill"
    case bookmarks = "bookmark.fill"
    case communities = "person.2.fill"
    case settings = "gearshape.fill"
    
    var content: String {
        switch self {
        case .home:
            "Home"
        case .search:
            "Search"
        case .notifications:
            "Notifications"
        case .bookmarks:
            "Bookmarks"
        case .communities:
            "Communities"
        case .settings:
            "Settings"
        }
    }
}

struct MoreTabBarHidden: View {
    @State private var activeTab: TabModel = .home
    @State private var isHidden: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                ForEach(TabModel.allCases, id: \.rawValue) { tab in
                    Tab.init(value: tab) {
                        Text(tab.content)
                            .toolbarVisibility(.hidden, for: .tabBar)
                            .background() {
                                if !isHidden {
                                    RemoveMoreNavigationBar {
                                        isHidden = true
                                    }
                                }
                            }
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach(TabModel.allCases, id: \.rawValue) { tab in
                    Button {
                        activeTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .font(.title3)
                            .foregroundStyle(activeTab == tab ? Color.primary : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .contentShape(.rect)
                    }
                }
            }
        }
    }
}

struct RemoveMoreNavigationBar: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let tabBarViewController = view.tabBarViewController {
                tabBarViewController.moreNavigationController.navigationBar.isHidden = true
                result()
            }
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
extension UIView {
    var tabBarViewController: UITabBarController? {
        if let controller = sequence(first: self, next: { item in
            item.next
        }).first(where: { $0 is UITabBarController }) as? UITabBarController {
            return controller
        }
        return nil
    }
}

#Preview {
    NavigationStack {
        MoreTabBarHidden()
    }
}
