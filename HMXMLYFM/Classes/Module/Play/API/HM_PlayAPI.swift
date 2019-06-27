//
//  HM_PlayAPI.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 播放页接口
let HM_PlayProvider = MoyaProvider<HM_PlayAPI>()

enum HM_PlayAPI {
    case fmPlayData(albumId:Int,trackUid:Int, uid:Int)
}

extension HM_PlayAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            return "/mobile/track/v2/playpage/\(trackUid)"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters = [
            "device":"iPhone",
            "operator":3,
            "scale":3,
            "appid":0,
            "ac":"WIFI",
            "network":"WIFI",
            "version":"6.5.3",
            "uid":124057809,
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            parmeters["albumId"] = albumId
            parmeters["trackUid"] = uid
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}
