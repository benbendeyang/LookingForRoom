//
//  HomeBannerCell.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  首页BannerCell

import UIKit

class HomeBannerCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    var clickSearckBlock: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        searchButton.layer.masksToBounds = false;
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.15
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickSearch(_ sender: Any) {
        clickSearckBlock?()
    }
    
}
