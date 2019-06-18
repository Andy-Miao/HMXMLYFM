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
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    public var path: String {
        switch self {
        case .homeBroadcastList:
            return "live-web/v5/homepage"
        case .categoryBroadcastList(let path):
            return path
        case .moreCategoryBroadcastList:
            return "live-web/v2/radio/category"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    // 是否执行Alamofire验证
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
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
            parmeters["provinceCode"] = categroryId
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        }
    }
    
}
