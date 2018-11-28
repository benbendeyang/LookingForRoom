//
//  HomeMainController.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit
import Alamofire

class HomeMainController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 操作
    @IBAction func test1(_ sender: Any) {
        Network.request(target: .demo1, success: { (result) in
            Log(result)
//            guard let internet = Internet(JSON: (result as? [String : AnyObject] ?? [:])) else { return }
//            Log(internet.origin)
//            Log(internet.url)
//            Log(internet.Connection)
//            Log(internet.Host)
//            Log(internet.Agent)
        }) { (error) in
            Log(error.localizedDescription)
        }
    }
    
    @IBAction func test2(_ sender: Any) {
        Network.request(target: .demo2(name: "wuhao"), success: { (result) in
            Log(result)
        }) { (error) in
            Log(error.localizedDescription)
        }
    }
    
    @IBAction func test3(_ sender: Any) {
        Network.request(target: .demo3(name: "wuhao", score: 100), success: { (result) in
            Log(result)
        }) { (error) in
            Log(error.localizedDescription)
        }
    }
    
    @IBAction func test4(_ sender: Any) {
        if KeychainManager.keyChainUpdata(data: "还是一只羊", with: "用户名") {
            print("更新成功")
        } else {
            print("更新失败")
        }
    }
    
    @IBAction func test5(_ sender: Any) {
    }
}
