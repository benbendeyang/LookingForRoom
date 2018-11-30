//
//  RequestResult.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  请求返回

import Foundation
import ObjectMapper

class RequestResult: Mappable {
    
    var requestId: Float = 0
    var errorCode: Int = 0
    var errorMsg: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        requestId   <- map["request_id"]
        errorCode   <- map["error_code"]
        errorMsg    <- map["error_msg"]
    }
}
