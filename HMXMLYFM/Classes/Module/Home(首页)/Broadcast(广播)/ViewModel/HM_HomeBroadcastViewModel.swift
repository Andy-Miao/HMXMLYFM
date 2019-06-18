//
//  HM_HomeBroadcastViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_HomeBroadcastViewModel: NSObject {
    // 更多电台分类是否展开状态
    var isUnfold: Bool = false
    /// 一下三个model是控制展开收起时电台数据显示
    let bottomModel = HM_RadiosCategoriesModel(id: 10000, name: "arrows_bottom.png")
    
    let topModel = HM_RadiosCategoriesModel(id: 10000, name: "arrows_top.png")
    let coverModel = HM_RadiosCategoriesModel(id: 10000, name: " ")
    
    var titleArr = ["上海", "排行榜"]
    // 数据模型
    var categories: [HM_RadiosCategoriesModel]?
    var localRadios: [HM_LocalRadiosModel]?
    var radioSquareResults: [HM_RadioSquareResultsModel]?
    var topRadios: [HM_TopRadiosModel]?
    
    // -  - 数据源更新
    typealias LBFMAddDataBlock = () ->Void
    var updataBlock:LBFMAddDataBlock?
}

extension HM_HomeBroadcastViewModel {
    func refreshDataSource() {
        HM_HomeBrodcastAPIProvider.request(.homeBroadcastList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_HomeBroadcastModel>.deserializeFrom(json: json.description) {
                    self.categories = mappedObject.data?.categories
                    self.localRadios = mappedObject.data?.localRadios
                    self.radioSquareResults = mappedObject.data?.radioSquareResults
                    self.topRadios = mappedObject.data?.topRadios
                    self.categories?.insert(self.bottomModel, at: 7)
                    self.categories?.append(self.topModel)
                    self.updataBlock?()
                }
            }
        }
    }
}

extension HM_HomeBroadcastViewModel {
    
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == HM_HomeBroadcastSectionTel {
            return 1
        } else if section == HM_HomeBroadcastSectionMoreTel {
            if self.isUnfold {
                return self.categories?.count ?? 0
            }else {
                let num:Int = self.categories?.count ?? 0
                return num / 2
            }
        }else if section == HM_HomeBroadcastSectionLocal {
            return self.localRadios?.count ?? 0
        }else {
            return self.topRadios?.count ?? 0
        }
    }
    
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        if section == HM_HomeBroadcastSectionMoreTel {
            return 1
        }else {
            return 0.0
        }
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        if section == HM_HomeBroadcastSectionMoreTel {
            return 1
        }else {
            return 0.0
        }
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == HM_HomeBroadcastSectionTel {
            return CGSize.init(width:SCREEN_WIDTH,height:90)
        }else if indexPath.section == HM_HomeBroadcastSectionMoreTel {
            return CGSize.init(width:(SCREEN_WIDTH-5)/4,height:45)
        }else {
            return CGSize.init(width:SCREEN_WIDTH,height:120)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == HM_HomeBroadcastSectionTel || section == HM_HomeBroadcastSectionMoreTel {
            return .zero
        }else {
            return CGSize.init(width: SCREEN_WIDTH, height: 40)
        }
    }
    
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        if section == HM_HomeBroadcastSectionTel || section == HM_HomeBroadcastSectionMoreTel {
            return .zero
        }else {
            return CGSize.init(width: SCREEN_WIDTH, height: 10)
        }
    }
}
