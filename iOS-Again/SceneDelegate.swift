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
            
            let rootViewController = UINavigationController(rootViewController: MainViewController())
            rootViewController.isNavigationBarHidden = true
            self.window?.rootViewController = rootViewController
            
            self.window?.makeKeyAndVisible()
        }
    }
}

