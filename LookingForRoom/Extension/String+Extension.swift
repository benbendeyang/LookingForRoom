//
//  String+Extension.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/27.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  String扩展

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
