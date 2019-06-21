
//
//  HM_VipAPI.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/21.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import Moya

//
let HM_VipAPIProvider = MoyaProvider<HM_VipAPI>()

///1 声明一个枚举
public enum HM_VipAPI {
    case vipList
}
/// 2 添加一个继承TatgetTpye的y拓展
extension HM_VipAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .vipList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .vipList:
            return "/product/v4/category/recommends/ts-1532592638951"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .vipList:
            let parmeters = [
                "appid":0,
                "categoryId":33,
                "contentType":"album",
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":0,
                "device":"iPhone",
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
      
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
