//
//  AppDelegate.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appStart = AppStart()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let breedsViewController: BreedsViewController = appStart.startApp()
        let navigationController = UINavigationController(rootViewController: breedsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
