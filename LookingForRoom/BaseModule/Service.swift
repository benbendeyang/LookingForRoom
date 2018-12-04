//
//  Service.swift
//  Pastime
//
//  Created by 🐑 on 2018/11/27.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  接口服务

import Foundation
import Moya

// 定义请求方法
enum Service {
    case recommendHouses(cityId: String, sign: String)
    case demo2(name: String)
    case demo3(name: String, score: Int)
}

extension Service: TargetType {
    //    https://www.sojson.com/open/api/weather/json.shtml?city=广州
    //    https://wx.api.ke.com/index/recommend/ershoufang?city_id=440100&sign=
    // 请求服务器的根路径
    var baseURL: URL { return URL.init(string: "https://wx.api.ke.com")! }
    
    // 请求头
    var headers: [String : String]? {
        return
            ["Content-type": "application/json",
             "Lianjia-Uuid": "e610c5d64abb560aa9802194cd47694d",
             "Authorization": "bGp3eGFwcDo4NDY3YzgyNTFjNTNhZGMxZDhhMTU0YjEyNjNjZjY2NQ==",
             "Lianjia-Source": "ljwxapp",
             "Time-Stamp": Date().milliStamp
        ]
    }
    
    // 每个API对应的具体路径
    var path: String {
        switch self {
        case .recommendHouses:
            return "/index/recommend/ershoufang"
        case .demo2(name: _), .demo3(name: _, score: _):
            return "/post"
        }
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .recommendHouses:
            return .get
        case .demo2, .demo3:
            return .post
        }
    }
    
    // 请求是否携带参数，如果需要参数，就做如demo2和demo3的设置
    var task: Task {
        switch self {
        case let .recommendHouses(cityId, sign):
            //            return .requestPlain // 无参数
            return .requestParameters(parameters: ["city_id" : cityId, "sign": sign], encoding: URLEncoding.default)
        case let .demo2(name): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name], encoding: URLEncoding.default)
        case let .demo3(name, score): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name, "score" : score], encoding: URLEncoding.default)
        }
    }
    
    // 单元测试使用
    var sampleData: Data {
        switch self {
        case .recommendHouses, .demo3:
            return "just for test".utf8Encoded
        case .demo2(let name):
            return "{\"name\": \(name)\"}".utf8Encoded
        }
    }
}

// 网络请求结构体
struct Network {
    
    enum RequestType {
        case load
        case cache
        case loadAndCache
    }
    
    // 请求成功的回调
    typealias successCallback = (_ result: Any) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: MoyaError) -> Void
    
    // 单例
    static let provider = MoyaProvider<Service>()
    static let cacheProvider: MoyaProvider<Service> = {
        return MoyaProvider(requestClosure: { (endpoint, closure) in
            var request = try! endpoint.urlRequest()
            request.cachePolicy = .returnCacheDataDontLoad
            closure(.success(request))
        })
    }()
    
    /// 发送网络请求
    static func request(target: Service, requestType: RequestType = .loadAndCache, success: @escaping successCallback, failure: @escaping failureCallback) {
        
        switch requestType {
        case .load:
            request(provider: provider, target: target, success: success, failure: failure)
        case .cache:
            request(provider: cacheProvider, target: target, success: success, failure: failure)
        case .loadAndCache:
            request(provider: provider, target: target, success: success, failure: failure)
            request(provider: cacheProvider, target: target, success: success, failure: failure)
        }
    }
    
    private static func request(provider: MoyaProvider<Service>, target: Service,success: @escaping successCallback, failure: @escaping failureCallback) {
        
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

