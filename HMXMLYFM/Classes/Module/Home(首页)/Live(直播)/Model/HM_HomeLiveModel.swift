//
//  HM_HomeLiveModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import HandyJSON

/// 直播顶部排行榜数据模型
struct HM_HomeLiveRankModel: HandyJSON {
    var data: HM_HomeLiveRankListModel?
    var ret: Int = 0
}

struct HM_HomeLiveRankListModel: HandyJSON {
    var hpRankRollMillisecond: Int = 0
    var multidimensionalRankVos: [HM_MultidimensionalRankVosModel]?
}

struct HM_MultidimensionalRankVosModel: HandyJSON {
    var dimensionName: String?
    var dimensionType: Int = 0
    var htmlUrl: String?
    var ranks: [HM_RankList]?
}

struct HM_RankList: HandyJSON {
    var coverSmall: String?
    var nickname: String?
    var uid: Int = 0
}

/// 直播顶部banner数据模型
struct HM_HomeLiveBanerModel: HandyJSON {
    var ret: Int = 0
    var responseId: Int = 0
    var data:[HM_HomeLiveBanerList]?
    var adIds: [Any]?
    var adTypes: [Any]?
    var source: Int = 0
}

struct HM_HomeLiveBanerList: HandyJSON {
    var shareData: String?
    var isShareFlag: String?
    var thirdStatUrl: String?
    var thirdShowStatUrls: [Any]?
    var thirdClickStatUrls: [Any]?
    var showTokens: [Any]?
    var clickTokens: [Any]?
    var recSrc: String?
    var recTrack: String?
    var link: String?
    var realLink: String?
    var adMark: String?
    var isLandScape: Bool = false
    var isInternal: Int = 0
    var bucketIds: String?
    var adpr: String?
    var planId: Int = 0
    var cover: String?
    var showstyle: Int = 0
    var name: String?
    var description: String?
    var scheme: String?
    var linkType: Int = 0
    var displayType: Int = 0
    var clickType: Int = 0
    var openlinkType: Int = 0
    var loadingShowTime: Int = 0
    var apkUrl: String?
    var adtype: Int = 0
    var auto: Bool = false
    var isAd: Bool = false
    var targetId: Int = 0
    var clickAction: Int = 0
    var template: String?
    var buttonText: String?
    var buttonShowed: Bool = false
    var categoryTitle: String?
    var color: String?
    var adid: Int = 0
}

/// 直播顶部分类数据模型
struct HM_HomeLiveClassifyModel: HandyJSON {
    var data: HM_HomeLiveClassify?
    var ret: Int = 0
}

struct HM_HomeLiveClassify: HandyJSON {
    var materialVoList: [HM_MaterialVoList]?
    var showed: Bool = false
}

struct HM_MaterialVoList: HandyJSON {
    var coverPath: String?
    var id: Int = 0
    var targetUrl: String?
    var title: String?
    var type: Int = 0
}

/// 直播主播数据模型
struct HM_HomeLiveModel: HandyJSON {
    var data:HM_HomeLiveDataModel?
    var ret: Int = 0
}

struct HM_HomeLiveDataModel: HandyJSON {
    var categoryVoList:[HM_CategoryVoList]?
    var lastPage: Bool = false
    var lives:[HM_LivesModel]?
    var pageId: Int = 0
    var pageSize: Int = 0
}

struct HM_CategoryVoList: HandyJSON {
    var id: String?
    var name: String?
}

struct HM_LivesModel: HandyJSON {
    var actualStartAt: Int = 0
    var avatar: String?
    var categoryId: Int = 0
    var categoryName: String?
    var chatId: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall: String?
    var id: Int = 0
    var mode: HM_Mode?
    var name: String?
    var nickname: String?
    var permissionType: Int = 0
    var playCount: Int = 0
    
    var price: Int = 0
    var roomId: Int = 0
    var status: Int = 0
    var uid: Int = 0
    var type: Int = 0
}

struct HM_Mode: HandyJSON {
    var firstColor: String?
    var modeName: String?
    var modeType: Int = 0
    var secondColor: String?
}
