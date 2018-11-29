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
//        mainTableView.estimatedRowHeight = 150
        viewModel.refreshData()
        mainTableView.reloadData()
    }
    
    // MARK: - 操作
}

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerCell", for: indexPath)
            return cell
            
        case .navigation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNavigationCell", for: indexPath)
            return cell
        
        case .market:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckMoreHouseCell", for: indexPath)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .banner:
            return UITableView.automaticDimension
        case .navigation:
            return 106
        case .market:
            return 135
        case .recommendHouses:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {
        case let .recommendHouses(rows):
            switch rows[indexPath.row] {
            case .house:
                if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
                }
                if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                    cell.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
                    
                }
            case .header, .footer:
                if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
                }
                if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                    cell.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
                }
            }
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section] {
        case let .recommendHouses(houses):
            let house = houses[indexPath.row]
            Log("点击:\(house)")
        case .banner, .navigation, .market: break
        }
    }
}
