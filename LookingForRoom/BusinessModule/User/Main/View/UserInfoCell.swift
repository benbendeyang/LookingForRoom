//
//  UserInfoCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/3.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    open func display(with user: User?) {
        if let user = user {
            titleLabel.text = user.id
        } else {
            titleLabel.text = "点击注册/登陆"
        }
    }

}
