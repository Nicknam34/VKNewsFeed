//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Radmir Dzhurabaev on 23.03.2025.
//  Copyright © 2025 Radmir Dzhurabaev. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    private var authService: AuthService!
        override func viewDidLoad() {
            super.viewDidLoad()
           // authService = AuthService()
            authService = AppDelegate.shared().authService
    }
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }

}
