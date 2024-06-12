//
//  SwiftUI_iOS17_Beta7_Demo.swift
//  SwiftUI_iOS17_Beta7_Demo
//
//  Created by Lurich on 2023/6/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftUI_iOS17_DemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    var windowShareModel = WindowShareModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(windowShareModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

@Observable
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    weak var windowScene: UIWindowScene? = nil
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
    }
    
    var heroWindow: UIWindow? = nil
    func addHeroWindow(_ windowShareModel: WindowShareModel) {
        guard let scene = windowScene else { return }
        let heroViewController = UIHostingController(rootView:
            CustomHeroAnimationView()
            .environment(windowShareModel)
            .allowsHitTesting(false)
        )
        heroViewController.view.backgroundColor = .clear
        let heroWindow = UIWindow(windowScene: scene)
        heroWindow.rootViewController = heroViewController
        heroWindow.isHidden = false
        heroWindow.isUserInteractionEnabled = false
        self.heroWindow = heroWindow
    }
    
    var tabWindow: UIWindow? = nil
    func addTabBar(_ windowShareModel: WindowShareModel) {
        guard let scene = windowScene else { return }
        let tabController = UIHostingController(rootView:
            CustomTabBar()
                .environment(windowShareModel)
        )
        tabController.view.backgroundColor = .clear
        
        let tabWindow = PassThroughWindow(windowScene: scene)
        tabWindow.rootViewController = tabController
        tabWindow.isHidden = false
        self.tabWindow = tabWindow
    }
}

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == view ? nil : view
    }
}
