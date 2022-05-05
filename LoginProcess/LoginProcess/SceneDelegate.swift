//
//  SceneDelegate.swift
//  LoginProcess
//
//  Created by 송태환 on 2022/05/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let controller = OnboardingController()
        self.window?.rootViewController = controller
//        self.window?.rootViewController = UINavigationController(rootViewController: controller)
        self.window?.makeKeyAndVisible()
    }
}
