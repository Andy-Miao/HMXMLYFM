//
//  HM_ListenAPI.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import Moya

let HM_ListenAPIProvider = MoyaProvider<HM_ListenAPI>()

public enum HM_ListenAPI {
    case listenSubscibeList
    case listenChannelList
    case listenMoreChannelList
}

extension HM_ListenAPI : TargetType {
    public var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    public var path: String {
        switch self {
        case .listenSubscibeList:
            return "/subscribe/v2/subscribe/comprehensive/rank"
        case .listenChannelList:
            return "/radio-station/v1/subscribe-channel/list"
        default:
            return "/subscribe/v3/subscribe/recommend"
        }
    }
    
    public var method:  Moya.Method { return .get }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        var parmeters = ["pageId":1] as [String : Any]
        switch self {
        case .listenSubscibeList:
            parmeters = [
                "pageSize":30,
                "pageId":1,
                "device":"iPhone",
                "sign":2,
                "size":30,
                "tsuid":124057809,
                "xt": Int32(Date().timeIntervalSince1970)
                ] as [String : Any]
        case .listenChannelList:
            break
        default:
            parmeters = [
                "pageSize":30,
                "pageId":1,
                "device":"iPhone"] as [String : Any]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
    
}
