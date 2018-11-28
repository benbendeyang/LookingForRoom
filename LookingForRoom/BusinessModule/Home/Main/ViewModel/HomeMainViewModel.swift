//
//  HomeMainViewModel.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/28.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation

class HomeMainViewModel {
    
    enum SectionType {
        case userInfo(String)
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
    
    open func refreshData() {
        sections.removeAll()
        
        sections.append(.userInfo("a"))
        sections.append(.function([.myFollow, .customerService]))
        sections.append(.logout)
    }
}
