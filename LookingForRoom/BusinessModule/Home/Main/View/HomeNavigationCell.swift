//
//  HomeNavigationCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  首页引导Cell

import UIKit

class HomeNavigationCell: UITableViewCell {

    @IBOutlet private var navigationButtons: [UIButton]!
    
    var clickNavigationBlock: ((_ index: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickNavigation(_ sender: UIButton) {
        guard let index = navigationButtons.index(of: sender) else { return }
        clickNavigationBlock?(index)
    }
}
