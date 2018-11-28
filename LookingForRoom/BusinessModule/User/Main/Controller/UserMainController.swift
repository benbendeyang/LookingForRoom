//
//  UserMainController.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  我的页

import UIKit

class UserMainController: BaseViewController {

    @IBOutlet private weak var mainTableView: UITableView!
    
    private let viewModel: UserMainViewModel = UserMainViewModel()
    
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

extension UserMainController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.sections[indexPath.section] {
            
        case .userInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath)
            return cell
            
        case let .function(rows):
            switch rows[indexPath.row] {
            case .myFollow:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyFollowCell", for: indexPath)
                return cell
            case .customerService:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerServiceCell", for: indexPath)
                return cell
            }
            
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .userInfo:
            return 110
        case .function:
            return 59
        case .logout:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section] {
        case let .function(rows):
            switch rows[indexPath.row] {
            case .myFollow:
                Log("点击我的关注")
            case .customerService:
                Log("点击客服电话")
            }
        case .logout:
            Log("点击退出登录")
        case .userInfo: break
        }
    }
}
