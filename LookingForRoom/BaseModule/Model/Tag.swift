//
//  Tag.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  标签

import Foundation
import ObjectMapper

class Tag: Mappable {
    
    var key: String = ""
    var title: String = ""
    var color: String = ""
    var textColor: String = ""
    var bgColor: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        key     <- map["key"]
        title   <- map["title"]
        color   <- map["color"]
        textColor   <- map["text_color"]
        bgColor     <- map["bg_color"]
    }
}

