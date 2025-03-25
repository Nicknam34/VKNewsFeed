//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Radmir Dzhurabaev on 21.03.2025.
//  Copyright © 2025 Radmir Dzhurabaev. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.authService = AuthService()
        authService.delegate = self
        guard let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController else {
            fatalError("Could not load AuthViewController from storyboard")
        }
        
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    //MARK AuthServiceDelegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
    }
    
    func authServiceDidSighInFail() {
        print(#function)
    }
    func authServiceDidSignInFail() {
        print(#function)
    }
}
