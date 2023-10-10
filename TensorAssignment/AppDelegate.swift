//
//  AppDelegate.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CoreLocation


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        if let isLoggedIn = UserDefaults.standard.object(forKey: UserDefaultKeys.isLoggedIn) as? Bool, isLoggedIn {
            self.showHomeScreen()
        }else {
            self.showLoginScreen()
        }
        
        return true
    }
}

extension AppDelegate {
    func showHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
