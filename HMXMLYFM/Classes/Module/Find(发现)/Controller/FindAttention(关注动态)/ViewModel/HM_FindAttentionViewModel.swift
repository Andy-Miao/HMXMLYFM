//
//  HM_FindAttentionViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_FindAttentionViewModel: NSObject {
    // 数据
    var eventInfos: [HM_EventInfosModel]?
    // 数据更新
    typealias HM_AddDataBlock = () ->Void
    var updataBlock:HM_AddDataBlock?
    
}
// 请求数据
extension HM_FindAttentionViewModel {
    func refreshDataSource() {
        // 获取路径
        let path = Bundle.main.path(forResource: "FindAttention", ofType: "json")
        // 通过路径
        let data = NSData(contentsOfFile: path!)
        // c转成json
        let json = JSON(data!)
        
        if let mappedObject = JSONDeserializer<HM_EventInfosModel>.deserializeModelArrayFrom(json: json["data"]["eventInfos"].description) {
            self.eventInfos = (mappedObject as! [HM_EventInfosModel])
            self.updataBlock?()
        }
    }
}
//  数据源
extension HM_FindAttentionViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.eventInfos?.count ?? 0
    }
    
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let picNum = self.eventInfos?[indexPath.row].contentInfo?.picInfos?.count ?? 0
        var num:CGFloat = 0
        if picNum > 0 && picNum <= 3 {
            num = 1
        }else if picNum > 3 && picNum <= 6{
            num = 2
        }else if picNum > 6{
            num = 3
        }
        let OnePicHeight = CGFloat((SCREEN_WIDTH - 30) / 3)
        let picHeight = num * OnePicHeight
        let textHeight:CGFloat = height(for: self.eventInfos?[indexPath.row].contentInfo)
        return 60+50+picHeight+textHeight
    }
    
    func height(for commentModel:  HM_FindAContentInfo?) -> CGFloat {
        var height: CGFloat = 44
        guard let model = commentModel else {
            return height
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:15)
        label.numberOfLines = 0
        label.text = model.text
        height += label.sizeThatFits(CGSize(width: SCREEN_WIDTH - 30, height: CGFloat.greatestFiniteMagnitude)).height + 10
        return height
    }
}

