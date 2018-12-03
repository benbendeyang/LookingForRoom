//
//  User.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/3.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id     <- map["id"]
    }
}
