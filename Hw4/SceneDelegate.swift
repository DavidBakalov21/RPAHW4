//
//  SceneDelegate.swift
//  Hw4
//
//  Created by david david on 06.11.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
                let window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        // https://developer.apple.com/documentation/uikit/uitabbarcontroller
        // https://github.com/firebase/quickstart-ios/blob/main/authentication/AuthenticationExample/SceneDelegate.swift
        // https://stackoverflow.com/questions/27407590/programmatically-setting-tabbaritem-title-in-swift
        let firstScreen = UINavigationController(rootViewController: ViewController())
        let secondScreen = UINavigationController(rootViewController: SecondScreen())
        let thirdScreen = UINavigationController(rootViewController: ThirdScreen())
        firstScreen.tabBarItem.title = "First"
        secondScreen.tabBarItem.title = "Second"
        thirdScreen.tabBarItem.title = "Third"
        tabBarController.viewControllers = [firstScreen, secondScreen, thirdScreen ]
        tabBarController.tabBar.backgroundColor = .white
                window.rootViewController = tabBarController
                self.window = window
                window.makeKeyAndVisible()
    }
}
