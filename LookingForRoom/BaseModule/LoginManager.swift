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
    
    static let shareManager = LoginManager()
    
    private(set) var isLogin: Bool = false
    
    class func login(presentingViewController: UIViewController?) {
        let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController")
        presentingViewController?.present(viewController, animated: true)
    }
    
}
