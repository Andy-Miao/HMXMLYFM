//
//  HM_HomeLiveViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_HomeLiveViewModel: NSObject {

    // 外部传值请求接口
    var categoryType :Int = 0
    convenience init(categoryType: Int = 0) {
        self.init()
        self.categoryType = categoryType
    }
    
    var homeLiveData: HM_HomeLiveDataModel?
    var lives:[HM_LivesModel]?
    var categoryVoList:[HM_CategoryVoList]?
    var homeLiveBanerList:[HM_HomeLiveBanerList]?
    var multidimensionalRankVos: [HM_MultidimensionalRankVosModel]?
    
    // - 数据源更新
    typealias HM_AddDataBlock = () ->Void
    var updataBlock:HM_AddDataBlock?
    
}

// - 请求数据
extension HM_HomeLiveViewModel {
    func refreshDataSource() {
        loadLiveData()
    }
    
    func loadLiveData(){
        let grpup = DispatchGroup()
        grpup.enter()
        // 首页直播接口请求
        HM_HomeLiveAPIProvider.request(.liveList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_HomeLiveModel>.deserializeFrom(json: json.description) {
                    self.lives = mappedObject.data?.lives
                    self.categoryVoList = mappedObject.data?.categoryVoList
                    //  self.collectionView.reloadData()
                    // 更新tableView数据
                    //  self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播滚动图接口请求
        HM_HomeLiveAPIProvider.request(.liveBannerList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_HomeLiveBanerModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.homeLiveBanerList = mappedObject.data
                    // let index: IndexPath = IndexPath.init(row: 0, section: 1)
                    // self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    // self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播排行榜接口请求
        HM_HomeLiveAPIProvider.request(.liveRankList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_HomeLiveRankModel>.deserializeFrom(json: json.description) {
                    self.multidimensionalRankVos = mappedObject.data?.multidimensionalRankVos
                    //  let index: IndexPath = IndexPath.init(row: 0, section: 2)
                    //  self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    //  self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.updataBlock?()
        }
    }
}

// - 点击分类刷新主页数据请求数据
extension HM_HomeLiveViewModel {
    func refreshCategoryLiveData() {
        loadCategoryLiveData()
    }
    func loadCategoryLiveData(){
        HM_HomeLiveAPIProvider.request(.categoryTypeList(categoryType:self.categoryType)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_LivesModel>.deserializeModelArrayFrom(json: json["data"]["lives"].description) {
                    self.lives = mappedObject as? [HM_LivesModel]
                }
                self.updataBlock?()
            }
        }
    }
}


// - collectionview数据
extension HM_HomeLiveViewModel {
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == HM_HomeLiveSectionLive {
            return self.lives?.count ?? 0
        }else {
            return 1
        }
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 5
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 10
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case HM_HomeLiveSectionGrid:
            return CGSize.init(width:SCREEN_WIDTH - 30,height:90)
        case HM_HomeLiveSectionBanner:
            return CGSize.init(width:SCREEN_WIDTH - 30,height:110)
        case HM_HomeLiveSectionRank:
            return CGSize.init(width:SCREEN_WIDTH - 30,height:70)
        default:
            return CGSize.init(width:(SCREEN_WIDTH - 40)/2,height:230)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == HM_HomeLiveSectionLive{
            return CGSize.init(width: SCREEN_WIDTH, height: 40)
        }else {
            return .zero
        }
    }
}
