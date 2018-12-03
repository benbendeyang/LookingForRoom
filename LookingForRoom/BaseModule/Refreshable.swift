//
//  Refreshable.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/3.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  刷新协议

import Foundation
import UIKit

protocol PullRefreshable {
    func startPullRefreshing()
    func stopPullRefreshing()
}

protocol PushRefreshable {
    func startPushRefreshing()
    func stopPushRefreshing()
}

protocol Refreshable: PullRefreshable, PushRefreshable {}

extension UITableView: Refreshable {
    
    func startPullRefreshing() {
        mj_header?.beginRefreshing()
    }
    
    func stopPullRefreshing() {
        mj_header?.endRefreshing()
    }
    
    func startPushRefreshing() {
        mj_footer?.beginRefreshing()
    }
    
    func stopPushRefreshing() {
        mj_footer?.endRefreshing()
    }
}
