//
//  HomeMainController.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class HomeMainController: BaseViewController {

    @IBOutlet private weak var mainTableView: UITableView!
    
    private let viewModel: HomeMainViewModel = HomeMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initController()
    }
    
    // MARK: - 初始化
    private func initController() {
        viewModel.refreshData()
        mainTableView.reloadData()
    }
    
    // MARK: - 操作
}

// MARK: - 私有方法
private extension HomeMainController {
    
    func toSearch() {
        print("去搜索")
    }
    
    func checkAllMarket() {
        print("查看全部行情")
    }
    
    func checkHouse(house: String) {
        print("查看：\(house)")
    }
    
    func clickNavigation(at index: Int) {
        switch index {
        case 0:
            print("点击二手房")
        case 1:
            print("点击新房")
        case 2:
            print("点击租房")
        case 3:
            print("点击去估价")
        default: break
        }
    }
    
    func checkAllHouse() {
        print("查看全部房源")
    }
    
    func separatorInset(cell: UITableViewCell, edgeInsets: UIEdgeInsets) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = edgeInsets
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = edgeInsets
        }
    }
}

// MARK: - 协议
extension HomeMainController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.sections[indexPath.section] {
            
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
            cell.clickSearckBlock = { [weak self] in
                self?.toSearch()
            }
            return cell
            
        case .navigation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNavigationCell", for: indexPath) as! HomeNavigationCell
            cell.clickNavigationBlock = { [weak self] index in
                self?.clickNavigation(at: index)
            }
            return cell
        
        case let .market(price, volume):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketCell
            cell.averagePriceLabel.text = price
            cell.volumeLabel.text = volume
            cell.clickCheckAllBlock = { [weak self] in
                self?.checkAllMarket()
            }
            return cell
            
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case .header:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendHouseTitleCell", for: indexPath)
                return cell
            case .house:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendHouseCell", for: indexPath)
                return cell
            case .footer:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckMoreHouseCell", for: indexPath) as! CheckMoreHouseCell
                cell.clickCheckAllBlock = { [weak self] in
                    self?.checkAllHouse()
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .banner:
            return 270
        case .navigation:
            return 120
        case .market:
            return 138
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case .header:
                return 48
            case .house:
                return 142
            case .footer:
                return 68
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isHouseExceptLast(indexPath: indexPath) {
            separatorInset(cell: cell, edgeInsets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
        } else {
            separatorInset(cell: cell, edgeInsets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: CGFloat.greatestFiniteMagnitude))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section] {
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case let .house(house):
                checkHouse(house: house)
            case .header, .footer: break
            }
        case .banner, .navigation, .market: break
        }
    }
}
