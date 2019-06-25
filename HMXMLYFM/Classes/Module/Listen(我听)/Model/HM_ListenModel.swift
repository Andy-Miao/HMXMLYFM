//
//  HM_ListenModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import Foundation
import HandyJSON

/// 订阅 Model
struct HM_AlbumResultsModel: HandyJSON {
    var albumCover: String?
    var albumId: Int = 0
    var albumTitle: String?
    var avatar: String?
    var dynamicType: Int = 0
    var isAuthorized: Bool = false
    var isDraft: Bool = false
    var isPaid: Bool = false
    var isTop: Bool = false
    var lastUpdateAt: NSInteger = 0
    var nickname: String?
    var serialState: Int = 0
    var status: Int = 0
    var timeline: NSInteger = 0
    var trackId: NSInteger = 0
    var trackTitle: String?
    var trackType: Int = 0
    var uid: NSInteger = 0
    var unreadNum: Int = 0
}


/// 一键听 Model
struct HM_ChannelResultsModel: HandyJSON {
    var bigCover: String?
    var channelId: Int = 0
    var channelName: String?
    var channelProperty: String?
    var cover: String?
    var createdAt: Int = 0
    var isRec: Bool = false
    var jumpUrl: String?
    var playParam: HM_PlayParamModel?
    var playUrl: String?
    var slogan: String?
}

struct HM_PlayParamModel: HandyJSON {
    var tabid: String?
    var pageSize: String?
    var albumId: String?
    var pageId: String?
    var isWrap: String?
    
}


/// 推荐 Model
struct HM_AlbumsModel:HandyJSON {
    var albumId: NSInteger = 0
    var coverMiddle: String?
    var coverSmall: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var lastUpdateAt: NSInteger = 0
    var playsCounts: NSInteger = 0
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var title: String?
    var tracks: Int = 0
}

/// 一键听点击添加更多频道 Model
struct HM_MoreChannelListModel: HandyJSON {
    var ret: Int = 0
    var msg: String?
    var slogan: String?
    var lastVisitChannel: HM_ChannelInfosModel?
    var classInfos: [HM_ChannelClassInfoModel]?
    var recSrc: String?
    var recTrack: String?
}

struct HM_ChannelInfosModel: HandyJSON{
    var channelProperty: String?
    var channelId: Int = 0
    var channelName: String?
    var positionId: Int = 0
    var cover: String?
    var bigCover: String?
    var isRec: Bool = false
    var jumpUrl: String?
    var playUrl: String?
    var slogan: String?
    var playParam: HM_PlayParamModel?
    var createdAt: Int = 0
    var subscribe: Bool = false
}

struct HM_ChannelClassInfoModel: HandyJSON {
    var className: String?
    var classId: Int = 0
    var channelInfos:[HM_ChannelInfosModel]?
}
