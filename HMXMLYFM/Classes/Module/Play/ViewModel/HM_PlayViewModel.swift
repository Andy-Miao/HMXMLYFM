//
//  HM_PlayViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_PlayViewModel: NSObject {
    // 外部传值请求接口如此那
    var albumId :Int = 0
    var trackUid:Int = 0
    var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0,uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    var playTrackInfo:HM_PlayTrackInfo?
    var playCommentInfo:[HM_PlayCommentInfo]?
    var userInfo:HM_PlayUserInfo?
    var communityInfo:HM_PlayCommunityInfo?
    // - 数据源更新
    typealias HM_AddDataBlock = () ->Void
    var updataBlock:HM_AddDataBlock?
}

// - 请求数据
extension HM_PlayViewModel {
    func refreshDataSource() {
        HM_PlayProvider.request(HM_PlayAPI.fmPlayData(albumId:self.albumId,trackUid:self.trackUid,uid:self.uid)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let playTrackInfo = JSONDeserializer<HM_PlayTrackInfo>.deserializeFrom(json: json["trackInfo"].description) {
                    self.playTrackInfo = playTrackInfo
                }
                // 从字符串转换为对象实例
                if let commentInfo = JSONDeserializer<HM_PlayCommentInfoList>.deserializeFrom(json: json["noCacheInfo"]["commentInfo"].description) {
                    self.playCommentInfo = commentInfo.list
                }
                // 从字符串转换为对象实例
                if let userInfoData = JSONDeserializer<HM_PlayUserInfo>.deserializeFrom(json: json["userInfo"].description) {
                    self.userInfo = userInfoData
                }
                // 从字符串转换为对象实例
                if let communityInfoData = JSONDeserializer<HM_PlayCommunityInfo>.deserializeFrom(json: json["noCacheInfo"]["communityInfo"].description) {
                    self.communityInfo = communityInfoData
                }
                self.updataBlock?()
            }
        }
    }
}

// - collectionview数据
extension HM_PlayViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return 4
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == 3{
            return self.playCommentInfo?.count ?? 0
        }
        return 1
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize.init(width:SCREEN_WIDTH,height:SCREEN_HEIGHT * 0.7)
        }else if indexPath.section == 3{
            let textHeight = height(for: self.playCommentInfo?[indexPath.row])+100
            return CGSize.init(width:SCREEN_WIDTH,height:textHeight)
        }else{
            return CGSize.init(width:SCREEN_WIDTH,height:140)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return CGSize.init(width: SCREEN_WIDTH, height:40)
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_WIDTH, height: 10.0)
    }
    
    // 计算文本高度
    func height(for commentModel: HM_PlayCommentInfo?) -> CGFloat {
        var height: CGFloat = 10
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = model.content
        height += label.sizeThatFits(CGSize(width: SCREEN_WIDTH - 80, height: CGFloat.infinity)).height
        return height
    }
}

