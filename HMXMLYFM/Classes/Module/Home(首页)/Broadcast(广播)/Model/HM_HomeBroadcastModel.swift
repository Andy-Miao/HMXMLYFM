//
//  HM_HomeBroadcastModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import HandyJSON

struct HM_HomeBroadcastModel: HandyJSON {
    var data: HM_RadiosModel?
    var ret: Int = 0
}

struct HM_RadiosModel: HandyJSON {
    var categories: [HM_RadiosCategoriesModel]?
    var localRadios: [HM_LocalRadiosModel]?
    var location: String?
    var radioSquareResults: [HM_RadioSquareResultsModel]?
    var topRadios: [HM_TopRadiosModel]?
}

struct HM_RadiosCategoriesModel: HandyJSON{
    var id: Int = 0
    var name: String?
}

struct HM_LocalRadiosModel :HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [HM_RadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}

struct HM_RadiosPlayUrlModel :HandyJSON {
    var aac24: String?
    var aac64: String?
    var ts24: String?
    var ts64: String?
}

struct HM_RadioSquareResultsModel: HandyJSON {
    var icon: String?
    var id: Int = 0
    var title: String?
    var uri: String?
}

struct HM_TopRadiosModel: HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [HM_RadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}
