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
    
    private static let accessTokenKey = "LoginStateAccessToken"
    
    static let shared = LoginManager()
    
    private(set) lazy var accessToken: String = {
        guard let accessToken = KeychainManager.keyChainReadData(identifier: LoginManager.accessTokenKey) as? String else { return "" }
        return accessToken
    }()
    
    var isLogin: Bool {
        return !accessToken.isEmpty
    }
    
    class func login(presentingViewController: UIViewController?) {
        let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController")
        presentingViewController?.present(viewController, animated: true)
    }
    
}
