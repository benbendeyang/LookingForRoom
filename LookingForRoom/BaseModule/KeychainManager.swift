//
//  KeychainManager.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/26.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  密钥管理

import Foundation

class KeychainManager {
    
    /// 创建查询条件
    class func createQuaryParameters(identifier: String) -> [String: Any] {
        // 创建一个条件字典
        var keychainQuaryParameters: [String: Any] = [:]
        // 设置条件存储的类型
        keychainQuaryParameters[kSecClass as String] = kSecClassGenericPassword
        // 设置存储数据的标记
        keychainQuaryParameters[kSecAttrService as String] = identifier
        keychainQuaryParameters[kSecAttrAccount as String] = identifier
        // 设置数据访问属性
        keychainQuaryParameters[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        return keychainQuaryParameters
    }
    
    /// 存储数据
    @discardableResult
    class func keyChainSaveData(data: Any ,with identifier: String) -> Bool {
        // 获取存储数据的条件
        var keychainQuaryParameters = createQuaryParameters(identifier: identifier)
        // 删除旧的存储数据
        SecItemDelete(keychainQuaryParameters as CFDictionary)
        // 设置数据
        keychainQuaryParameters[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: data)
        // 进行存储数据
        let saveState = SecItemAdd(keychainQuaryParameters as CFDictionary, nil)
        return (saveState == noErr)
    }
    
    /// 更新数据
    @discardableResult
    class func keyChainUpdata(data: Any ,with identifier: String) -> Bool {
        // 获取更新的条件
        let keychainUpdataParameters = createQuaryParameters(identifier: identifier)
        // 创建数据存储字典
        var updataParameters: [String: Any] = [:]
        // 设置数据
        updataParameters[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: data)
        // 更新数据
        let updataStatus = SecItemUpdate(keychainUpdataParameters as CFDictionary, updataParameters as CFDictionary)
        return (updataStatus == noErr)
    }
    
    /// 删除数据
    @discardableResult
    class func keyChianDelete(identifier: String)  -> Bool {
        // 获取删除的条件
        let keyChainDeleteMutableDictionary = self.createQuaryParameters(identifier: identifier)
        // 删除数据
        let deleteStatus = SecItemDelete(keyChainDeleteMutableDictionary as CFDictionary)
        return (deleteStatus == noErr)
    }
    
    /// 获取数据
    class func keyChainReadData(identifier: String) -> Any {
        var idObject: Any?
        // 获取查询条件
        var keyChainReadParameters = createQuaryParameters(identifier: identifier)
        // 提供查询数据的两个必要参数
        keyChainReadParameters[kSecReturnData as String] = kCFBooleanTrue
        keyChainReadParameters[kSecMatchLimit as String] = kSecMatchLimitOne
        // 创建获取数据的引用
        var queryResult: AnyObject?
        // 通过查询是否存储在数据
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadParameters as CFDictionary, UnsafeMutablePointer($0))}
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
            }
        }
        return idObject as Any
    }
}
