//
//  SceneDelegate.swift
//  PipeCAD
//
//  Created by Даниил Павленко on 04.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
            let window = UIWindow(windowScene: windowScene)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
            let navController = UINavigationController(rootViewController: vc)
            window.rootViewController = navController
            window.makeKeyAndVisible()
            self.window = window
    }
}
