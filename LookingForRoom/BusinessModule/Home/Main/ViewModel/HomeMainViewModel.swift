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
        case banner
        case navigation
        case market(price: String, volume: String)
        case recommendHouses([RecommendHousesRowType])
        
        enum RecommendHousesRowType {
            case header
            case house(String)
            case footer
        }
        
        var rowCount: Int {
            switch self {
            case .banner, .navigation, .market:
                return 1
            case let .recommendHouses(rows):
                return rows.count
            }
        }
    }
    
    // MARK: - 成员变量
    // MARK: 公共
    open var sections: [HomeMainViewModel.SectionType] = []
    
    open func refreshData() {
        sections.removeAll()
        
        sections.append(.banner)
        sections.append(.navigation)
        sections.append(.market(price: "32780", volume: "7"))
        sections.append(.recommendHouses([.header, .house("a"), .house("b"), .house("c"), .footer]))
    }
    
    open func isHouseExceptLast(indexPath: IndexPath) -> Bool {
        switch sections[indexPath.section] {
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case .header, .footer:
                return false
            case .house:
                let nextRow = indexPath.row + 1
                return (nextRow < (rows.count - 1))
            }
        default:
            return false
        }
    }
}
