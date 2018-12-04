//
//  HouseDetailsController.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/4.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class HouseDetailsController: UIViewController {

    static func fromStoryboard() -> HouseDetailsController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let houseDetailsController = storyboard.instantiateViewController(withIdentifier: String(describing: HouseDetailsController.self)) as? HouseDetailsController else {
            return HouseDetailsController()
        }
        return houseDetailsController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func test(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
