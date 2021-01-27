//
//  SceneDelegate.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKey()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
    }


}

