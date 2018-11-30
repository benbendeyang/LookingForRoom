//
//  HouseTagCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

class HouseTagCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open func display(tag: Tag) {
        tagLabel.text = tag.title
        tagLabel.textColor = UIColor(hexString: tag.color)
        backgroundColor = UIColor(hexString: tag.color, alpha: 0.15)
    }
}
