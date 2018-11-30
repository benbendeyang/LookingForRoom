//
//  House+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation

extension House: HouseCellDisplayProtocol {
    
    var pTitle: String {
        return title
    }
    
    var pDescribe: String {
        var describeList: [String] = []
        if !frameType.isEmpty {
            describeList.append(frameType)
        }
        if !houseArea.isNaN {
            describeList.append("\(houseArea)m²")
        }
        if !orientation.isEmpty {
            describeList.append(orientation)
        }
        if !resblockName.isEmpty {
            describeList.append(resblockName)
        }
        return describeList.joined(separator: "/")
    }
    
    var pTags: [Tag] {
        return tags
    }
    
    var pTotalPrice: String {
        return "\(totalPrice)万"
    }
    
    var pUnitPrice: String {
        return "\(unitPrice)元/平"
    }
}
