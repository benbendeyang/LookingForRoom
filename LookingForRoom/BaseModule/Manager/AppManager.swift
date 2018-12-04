//
//  AppManager.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/4.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  App管理

import Foundation
import UIKit
import Kingfisher

class AppManager {
    
    static func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        let cache = KingfisherManager.shared.cache
        cache.clearDiskCache()
        cache.clearMemoryCache()
        cache.cleanExpiredDiskCache()
        UIApplication.shared.keyWindow?.toast("清理成功")
    }
    
    @discardableResult
    static func makeCall(_ phone: String?) -> Bool {
        guard let phone = phone else { return false }
        guard let url = URL(string: "telprompt://\(phone)") else { return false }
        return UIApplication.shared.openURL(url)
    }
}
