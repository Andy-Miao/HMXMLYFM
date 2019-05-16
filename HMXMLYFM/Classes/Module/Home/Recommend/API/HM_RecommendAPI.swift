//
//  HM_RecommendAPI.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

let HM_RecommendProvider = MoyaProvider<HM_RecommendAPI>()

enum HM_RecommendAPI {
    // 推荐列表
    case recommendList
    // 为你推荐
    case recommendForYouList
    // 推荐页面穿插的广告
    case recommendAdList
    // 猜你喜欢更多
    case guessYouLikeMoreList
    // 更换猜你喜欢
    case changeGuessYouLikeList
    // 更换精品
    case changePaidCategoryList
    // 更换直播
    case changeLiveList
    // 更换其他
    case changeOtherCategory(categoryId:Int)
}

extension HM_RecommendAPI : TargetType {
    public var baseURL: URL {
        switch self {
        case .recommendAdList:
            return URL(string: "http://adse.ximalaya.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .recommendList:
            return "/discovery-firstpage/v2/explore/ts-1532411485052"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .recommendList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "categoryId":-2,
                "channel":"ios-b1",
                "code":"43_310000_3100",
                "includeActivity":true,
                "includeSpecial":true,
                "network":"WIFI",
                "operator":3,
                "pullToRefresh":true,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        default:
            parmeters =  [ "currentRecordIds":"1655918%2C1671613%2C1673030%2C1670774%2C1673082%2C1672407",
            "pageId":1,
            "pageSize":6,
            "device":"iPhone"
            ]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
}
