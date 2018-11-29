//
//  CheckMoreHouseCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class CheckMoreHouseCell: UITableViewCell {

    var clickCheckAllBlock: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickCheckAll(_ sender: Any) {
        clickCheckAllBlock?()
    }
}
