//
//  CGFloat+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/29.
//  Copyright © 2018 Zhu. All rights reserved.
//

import UIKit

extension CGFloat {
    
    var aligned: CGFloat {
        let floorSelf = floor(self)
        let diff = self - floorSelf
        let element = 1 / UIScreen.main.scale
        let diffInt = Int(diff * 10000)
        let elementInt = Int(element * 10000)
        if diffInt % elementInt == 0 {
            return self
        } else {
            return CGFloat(diffInt / elementInt + 1) * element + floorSelf
        }
    }
}
