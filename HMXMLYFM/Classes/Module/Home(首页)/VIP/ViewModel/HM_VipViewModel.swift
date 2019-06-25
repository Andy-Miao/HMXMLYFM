//
//  HM_VipViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/21.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
class HM_VipViewModel: NSObject {

    /// 定义model
    var vipData: HM_VipModel?
    var focusImages: [HM_FocusImagesData]?
    public var categoryList: [HM_CategoryList]?
    var categoryBtnList: [HM_CategoryBtnModel]?
    
    // Mark: - 数据更新
    typealias HM_AddDataBlock = () ->Void
    var updataBlock: HM_AddDataBlock?
    
   
}

// 请求接口
extension HM_VipViewModel {
    func refreshDataSource() {
        // 首页vip接口请求
        HM_VipAPIProvider.request(.vipList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
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
                    self.updataBlock?()
                    return;
                }
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_VipModel>.deserializeFrom(json: json.description) {
                    
                    self.vipData = mappedObject
                    self.focusImages = mappedObject.focusImages?.data
                    self.categoryList = mappedObject.categoryContents?.list
                }
                
                if let categoryBtn = JSONDeserializer<HM_CategoryBtnModel>.deserializeModelArrayFrom(json: json["categoryContents"]["list"][0]["list"].description) {
                    self.categoryBtnList = categoryBtn as?[HM_CategoryBtnModel]
                }
                self.updataBlock?()
            }
        }
    }
}

// 数据
extension HM_VipViewModel {
    
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        switch section {
        case HM_HomeVipSectionVip:
             return self.categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case HM_HomeVipSectionBanner:
            return 150
        case HM_HomeVipSectionGrid:
            return 80
        case HM_HomeVipSectionHot:
            return 190
        case HM_HomeVipSectionEnjoy:
            return 230
        default:
            return 120
        }
    }
    
    // header高度
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == HM_HomeVipSectionBanner || section == HM_HomeVipSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    // footer 高度
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == HM_HomeVipSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
}
