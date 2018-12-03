//
//  LoginManager.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  登陆管理

import UIKit

class LoginManager {
    
    static let NotificationUserDidLogin = "NotificationUserDidLogin"
    static let NotificationUserDidLogout = "NotificationUserDidLogout"
    private static let accessTokenKey = "LoginStateAccessToken"
    
    static let shared = LoginManager()
    
    private(set) var accessToken: String = KeychainManager.keyChainReadData(identifier: LoginManager.accessTokenKey) as? String ?? "" {
        didSet {
            if accessToken.isEmpty {
                KeychainManager.keyChianDelete(identifier: LoginManager.accessTokenKey)
            } else {
                KeychainManager.keyChainSaveData(data: accessToken, identifier: LoginManager.accessTokenKey)
            }
        }
    }
    
    var isLogin: Bool {
        return !accessToken.isEmpty
    }
    
    class func login(presentingViewController: UIViewController?) {
        let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController")
        DispatchQueue.main.async {
            presentingViewController?.present(viewController, animated: true)
        }
    }
    
    class func login(progress: ProgressDelegate? = nil, phone: String, password: String, successAction:(() -> Void)?) {
        // Todo: 登陆
        LoginManager.shared.accessToken = "asf"
        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationUserDidLogin), object: nil)
        
        progress?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            progress?.finishLoading()
            successAction?()
        }
    }
    
    class func logout() {
        LoginManager.shared.accessToken = ""
        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationUserDidLogout), object: nil)
    }
}
