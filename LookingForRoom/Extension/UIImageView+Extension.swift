//
//  UIImageView+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  UIImageView扩展

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String, placeholder: Placeholder? = nil) {
        kf.setImage(with: URL(string: urlString), placeholder: placeholder)
    }
    
    
}
