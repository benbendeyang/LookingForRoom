//
//  Service.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/27.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  网络

import Foundation
import Moya

// 定义请求方法
enum Service {
    case demo1
    case demo2(name: String)
    case demo3(name: String, score: Int)
}

// 网络请求结构体
struct Network {
    
    // 请求成功的回调
    typealias successCallback = (_ result: Any) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: MoyaError) -> Void
    
    // 单例
    static let provider = MoyaProvider<Service>()

    /// 发送网络请求
    static func request(
        target: Service,
        success: @escaping successCallback,
        failure: @escaping failureCallback
        ) {

        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    try success(moyaResponse.mapJSON()) // 测试用JSON数据
                } catch {
                    failure(MoyaError.jsonMapping(moyaResponse))
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}

extension Service: TargetType {
//    https://www.sojson.com/open/api/weather/json.shtml?city=广州
    // 请求服务器的根路径
    var baseURL: URL { return URL.init(string: "https://www.sojson.com")! }
    
    // 每个API对应的具体路径
    var path: String {
        switch self {
        case .demo1:
            return "/open/api/weather/json.shtml"
        case .demo2(name: _), .demo3(name: _, score: _):
            return "/post"
        }
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .demo1:
            return .get
        case .demo2, .demo3:
            return .post
        }
    }
    
    // 请求是否携带参数，如果需要参数，就做如demo2和demo3的设置
    var task: Task {
        switch self {
        case .demo1:
//            return .requestPlain // 无参数
            return .requestParameters(parameters: ["city" : "广州"], encoding: URLEncoding.default)
        case let .demo2(name): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name], encoding: URLEncoding.default)
        case let .demo3(name, score): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name, "score" : score], encoding: URLEncoding.default)
        }
    }
    
    // 单元测试使用
    var sampleData: Data {
        switch self {
        case .demo1, .demo3:
            return "just for test".utf8Encoded
        case .demo2(let name):
            return "{\"name\": \(name)\"}".utf8Encoded
        }
    }
    
    // 请求头
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}
