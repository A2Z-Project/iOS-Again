//
//  SceneDelegate.swift
//  iOS-Again
//
//  Created by DDang on 2023/01/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            self.window?.overrideUserInterfaceStyle = .light
            self.window?.backgroundColor = .white
            
            let realm = RealmStorageService()
            let rootViewController: UINavigationController
            let user = realm.getUser()
            
            /// Local에 저장된 사용자 정보에 따라 rootView를 분기
            if user == nil {
                rootViewController = UINavigationController(rootViewController: RootViewController())
            } else {
                rootViewController = UINavigationController(rootViewController: MainViewController())
            }
            
            rootViewController.isNavigationBarHidden = true
            self.window?.rootViewController = rootViewController
            
            self.window?.makeKeyAndVisible()
        }
    }
}

