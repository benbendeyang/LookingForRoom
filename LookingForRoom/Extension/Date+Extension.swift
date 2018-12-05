//
//  Date+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  Date扩展

import Foundation

extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
}
