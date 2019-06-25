//
//  HM_HomeBroadcastAPI.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import Moya


let HM_HomeBrodcastAPIProvider = MoyaProvider<HM_HomeBroadcastAPI>()

// 请求分类
public enum HM_HomeBroadcastAPI {
    case homeBroadcastList
    case categoryBroadcastList(path:String)
    case moreCategoryBroadcastList(categroryId:Int)
}

extension HM_HomeBroadcastAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://live.ximalaya.com")!
    }
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .homeBroadcastList:
            return "/live-web/v5/homepage"
        case .categoryBroadcastList(let path):
            return path
        case .moreCategoryBroadcastList:
            return "/live-web/v2/radio/category"
        }
    }
    // 请求类型
    public var method: Moya.Method {
        return .get
    }
    
    // 是否执行Alamofire验证
//    public var validate: Bool {
//        return false
//    }
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    // 请求头
    public var headers: [String : String]? {
        return nil
    }
    // 请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .homeBroadcastList:
            return .requestPlain
        case .categoryBroadcastList:
            let parmeters = [
                "device":"iphone",
                "pageNum":1,
                "pageSize":30,
                "provinceCode":"310000"] as [String : Any]
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .moreCategoryBroadcastList(let categroryId):
            var parmeters = ["device":"iphone",
                             "pageNum":1,
                             "pageSize":30,
                             "provinceCode":"310000"] as [String : Any]
            parmeters["categoryId"] = categroryId
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        }
    }
    
}
