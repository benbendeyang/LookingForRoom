//
//  UserMainViewModel.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/28.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation

class UserMainViewModel {
    
    enum SectionType {
        case userInfo(User?)
        case function([FunctionRowType])
        case logout
        
        enum FunctionRowType {
            case myFollow
            case customerService
        }
        
        var rowCount: Int {
            switch self {
            case .userInfo:
                return 1
            case let .function(rows):
                return rows.count
            case .logout:
                return 1
            }
        }
    }
    
    // MARK: - 成员变量
    // MARK: 公共
    open var sections: [UserMainViewModel.SectionType] = []
    open var update: (() -> Void)?
    
    // MARK: - 方法
    // MARK: 公共
    open func configUpdateAndRefreshData(update: (() -> Void)?) {
        self.update = update
        refreshData()
    }
    
    open func refreshData() {
        configSections()
    }
    
    // MARK: 私有
    private func configSections() {
        sections.removeAll()
        
        sections.append(.userInfo(LoginManager.shared.isLogin ? User(JSON: ["id": "13876543210"]) : nil))
        sections.append(.function([.myFollow, .customerService]))
        if LoginManager.shared.isLogin {
            sections.append(.logout)
        }
        
        update?()
    }
}
