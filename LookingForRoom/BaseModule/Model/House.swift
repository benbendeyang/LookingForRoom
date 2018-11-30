//
//  House.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  房源

import Foundation
import ObjectMapper

class House: Mappable {
    
    var title: String = ""
    var frameType: String = ""
    var houseArea: CGFloat = 0
    var orientation: String = ""
    var resblockName: String = ""
    var totalPrice: Int = 0
    var unitPrice: Int = 0
    var tags: [Tag] = []
    var picUrl: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title       <- map["title"]
        frameType   <- map["frame_type"]
        houseArea   <- map["house_area"]
        orientation     <- map["orientation"]
        resblockName    <- map["resblock_name"]
        totalPrice  <- map["total_price"]
        unitPrice   <- map["unit_price"]
        tags        <- map["tags"]
        picUrl      <- map["list_pic_url"]
    }
}

