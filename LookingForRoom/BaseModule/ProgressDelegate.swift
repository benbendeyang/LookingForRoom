//
//  ProgressDelegate.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/3.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation
import MBProgressHUD

protocol ProgressDelegate {
    func startLoading()
    func finishLoading()
}

class HUDAccessory: ProgressDelegate {
    
    private let message: String?
    private weak var view: UIView?
    private weak var hud: MBProgressHUD?
    init(view: UIView?, message: String? = nil) {
        self.view = view
        self.message = message
    }
    
    func startLoading() {
        hud = view?.showHUD(message)
    }
    
    func finishLoading() {
        hud?.hide(animated: true)
    }
}

class RefreshAccessory<T: Refreshable>: ProgressDelegate {
    
    private let refreshable: T?
    
    init(refreshable: T?) {
        self.refreshable = refreshable
    }
    
    func startLoading() {
    }
    
    func finishLoading() {
        refreshable?.stopPullRefreshing()
        refreshable?.stopPushRefreshing()
    }
}
