//
//  LoginController.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/20.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class LoginController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - 操作
    @IBAction func clickCancel(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        print("点击登陆")
    }
    
    @IBAction func clickRegister(_ sender: Any) {
        print("点击注册")
    }
}
