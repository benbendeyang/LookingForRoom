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
        case banner(String)
        case navigation
        case market
        case logout
        
        enum FunctionRowType {
            case myFollow
            case customerService
        }
        
        var rowCount: Int {
            switch self {
            case .banner, .navigation, .market:
                return 1
            case .logout:
                return 1
            }
        }
    }
    
    // MARK: - 成员变量
    // MARK: 公共
    open var sections: [HomeMainViewModel.SectionType] = []
    
    open func refreshData() {
        sections.removeAll()
        
        sections.append(.banner("a"))
        sections.append(.navigation)
        sections.append(.market)
        sections.append(.logout)
    }
}
