//
//  AppDelegate.swift
//  Hw4
//
//  Created by david david on 06.11.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let catFetcher = CatBreedFetcher()
    
    @Published var liked: [String] = []
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        catFetcher.fetchCatsForBreeds()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, 
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

}
