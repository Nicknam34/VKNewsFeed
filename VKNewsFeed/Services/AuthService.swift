//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Radmir Dzhurabaev on 23.03.2025.
//  Copyright © 2025 Radmir Dzhurabaev. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "53319997"  // Укажите ваш реальный App ID
    private let vkSdk: VKSdk
    var delegate: AuthServiceDelegate?

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["email", "offline"]

        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                self.delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                // Используем WebView вместо Safari
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                self.delegate?.authServiceDidSignInFail()
            }
        }
    }

    // MARK: - VKSdk Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("Authorization finished")
        if let token = result?.token {
            print("Access Token: \(token.accessToken)")
            delegate?.authServiceSignIn()
        } else {
            delegate?.authServiceDidSignInFail()
        }
    }

    func vkSdkUserAuthorizationFailed() {
        print("Authorization failed")
        delegate?.authServiceDidSignInFail()
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("Captcha required")
    }
}
