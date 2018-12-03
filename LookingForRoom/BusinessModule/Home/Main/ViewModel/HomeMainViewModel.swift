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
            case house(House)
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
    open var update: (() -> Void)?
    
    // MARK: 私有
    private var recommendHouses: [House] = []
    
    // MARK: - 方法
    // MARK: 公共
    open func configUpdateAndRefreshData(update: (() -> Void)?) {
        self.update = update
        refreshData()
    }
    
    open func refreshData(progressDelegate: ProgressDelegate? = nil) {
        Network.request(target: .recommendHouses(cityId: "440100", sign: ""), success: { [weak self] (result) in
            progressDelegate?.finishLoading()
            guard let `self` = self, let resultDict = result as? [String : AnyObject], let data = resultDict["data"] as? [String : AnyObject] else { return }
            self.recommendHouses.removeAll()
            data.forEach({ (_, value) in
                if let valueDict = value as? [String : AnyObject], let house = House(JSON: valueDict) {
                    self.recommendHouses.append(house)}
                }
            )
            self.configSections()
        }) { (error) in
            progressDelegate?.finishLoading()
            Log(error.localizedDescription)
        }
    }
    
    open func isHouseExceptLast(indexPath: IndexPath) -> Bool {
        switch sections[indexPath.section] {
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case .header, .footer:
                return false
            case .house:
                return indexPath.row < (rows.count - 2)
            }
        default:
            return false
        }
    }
    
    // MARK: 私有
    private func configSections() {
        sections.removeAll()
        
        sections.append(.banner)
        sections.append(.navigation)
        sections.append(.market(price: "32780", volume: "7"))
        var recommendRows: [SectionType.RecommendHousesRowType] = []
        if recommendHouses.count > 0 {
            recommendRows.append(.header)
            recommendHouses.forEach { house in
                recommendRows.append(.house(house))
            }
            recommendRows.append(.footer)
            sections.append(.recommendHouses(recommendRows))
        }
        
        update?()
    }
}
