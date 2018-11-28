//
//  Internet.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/27.
//  Copyright © 2018 Zhu. All rights reserved.
//

import Foundation
import ObjectMapper

class Internet: Mappable {
    
    var origin: String = ""
    var url: String = ""
    var Connection: String = ""
    var Host: String = ""
    var Agent: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        origin      <- map["origin"]
        url         <- map["url"]
        Connection  <- map["headers.Connection"]
        Host        <- map["headers.Host"]
        Agent       <- map["headers.User-Agent"]
    }
}
