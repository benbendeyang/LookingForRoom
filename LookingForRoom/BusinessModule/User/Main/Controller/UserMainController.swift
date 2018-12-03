//
//  UserMainController.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  我的页

import UIKit
import MBProgressHUD

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
        NotificationCenter.default.addObserver(self, selector: #selector(loginChange), name: NSNotification.Name(rawValue: LoginManager.NotificationUserDidLogin), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginChange), name: NSNotification.Name(rawValue: LoginManager.NotificationUserDidLogout), object: nil)
        
        viewModel.configUpdateAndRefreshData { [weak self] in
            self?.mainTableView.reloadData()
        }
    }
    
    // MARK: - 操作
}

private extension UserMainController {
    
    @objc func loginChange() {
        viewModel.refreshData()
    }
    
    func toLogin() {
        LoginManager.login(presentingViewController: self)
    }
    
    func logout() {
        LoginManager.logout()
    }
    
    func toMyFollow() {
        print("点击我的关注")
    }
    
    func callCustomerService() {
        let controller = UIAlertController(title: "呼叫:10106188", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确认", style: .default) { _ in
            print("呼叫:10106188")
        }
        controller.addAction(cancelAction)
        controller.addAction(confirmAction)
        present(controller, animated: true, completion: nil)
    }
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
            
        case let .userInfo(user):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
            cell.display(with: user)
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
        case .userInfo:
            guard !LoginManager.shared.isLogin else { return }
            toLogin()
        case let .function(rows):
            switch rows[indexPath.row] {
            case .myFollow:
                toMyFollow()
            case .customerService:
                callCustomerService()
            }
        case .logout:
            logout()
        }
    }
}
