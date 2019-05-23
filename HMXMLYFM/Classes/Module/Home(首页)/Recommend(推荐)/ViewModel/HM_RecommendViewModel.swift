//
//  HM_RecommendViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

class HM_RecommendViewModel: NSObject {

    //MARK: - 数据模型
    var homeRecommendModel          : HM_HomeRecommendModel?
    var homeRecommendListModel      : [HM_RecommendModel]?
    var recommendListModel          : [HM_RecommendListModel]?
    var focusModel                  : HM_FocusModel?
    var squareListModel             : [HM_SquareModel]?
    var topBuzzListmodel            : [HM_TopBuzzModel]?
    var guessYouLikeListModel       : [HM_GuessYouLikeModel]?
    var paidCategoryListModel       : [HM_PaidCategoryModel]?
    var playlistModel               : HM_PlaylistModel?
    var oneKeyListenListModel       : [HM_OneKeyListenModel]?
    var liveListModel               : [HM_LiveModel]?
    
    //MARK: - 数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
}

extension HM_RecommendViewModel {
    func refreshDataSource() {
        HM_RecommendProvider.request(.recommendList) { (result) in
            if case let .success(response) = result {
                // 解析
                let data = try?response.mapJSON()
                guard (data != nil) else {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                        let warning = MessageView.viewFromNib(layout: .cardView)
                        warning.configureDropShadow()
                        
                        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                        warning.configureContent(title: "", body: "亲，系统出错啦，等等再试好不啦？", iconText: iconText)
                        warning.button?.isHidden = true
                        var warningConfig = SwiftMessages.defaultConfig
                        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
                        SwiftMessages.show(config: warningConfig, view: warning)
                    })
                    self.updateDataBlock?()
                    return;
                }
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_HomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.homeRecommendModel = mappedObject
                    self.homeRecommendListModel = mappedObject.list
                    if let recommendListModel = JSONDeserializer<HM_RecommendListModel>.deserializeModelArrayFrom(json:json["list"].description){
                        self.recommendListModel = recommendListModel as?[HM_RecommendListModel]
                    }
                    
                    if let focusModel = JSONDeserializer<HM_FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focusModel = focusModel
                    }
                    
                    if  let squareModel = JSONDeserializer<HM_SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareListModel = squareModel as?[HM_SquareModel]
                    }
                    
                    
                    if let topBuzzModel = JSONDeserializer<HM_TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzListmodel = topBuzzModel as? [HM_TopBuzzModel]
                    }
                    
                    if let oneKeyListenModel = JSONDeserializer<HM_OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenListModel = oneKeyListenModel as? [HM_OneKeyListenModel]
                    }
                    
                    if let liveListModel = JSONDeserializer<HM_LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveListModel = liveListModel as? [HM_LiveModel]
                    }
                    self.updateDataBlock?()
                }
                
            }
        }
    }
}
// collectionview数据
extension HM_RecommendViewModel {
    
    func numberOfSections(collectionView:UICollectionView) -> Int {
         return (self.homeRecommendListModel?.count) ?? 0
    }
    
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }

    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight:Int = 90
        let itemNums = (self.homeRecommendListModel?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendListModel?[indexPath.section].list?.count
        let moduleType = self.homeRecommendListModel?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:SCREEN_WIDTH,height:360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width:SCREEN_WIDTH,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width:SCREEN_WIDTH,height:CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize.init(width:SCREEN_WIDTH,height:240)
        }else if moduleType == "oneKeyListen" {
            return CGSize.init(width:SCREEN_WIDTH,height:180)
        }else {
            return .zero
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendListModel?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: SCREEN_HEIGHT, height:40)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendListModel?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: SCREEN_WIDTH, height: 10.0)
        }
    }
    
}
