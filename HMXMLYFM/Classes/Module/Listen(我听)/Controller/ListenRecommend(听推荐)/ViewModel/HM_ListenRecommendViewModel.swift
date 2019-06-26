//
//  HM_ListenRecommendViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


class HM_ListenRecommendViewModel: NSObject {

    var albums:[HM_AlbumsModel]?
    // - 数据源更新
    typealias HM_AddDataBlock = () -> Void
    var updataBlock: HM_AddDataBlock?
}

extension HM_ListenRecommendViewModel {
    func refreshDataSource() {
        // 1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenRecommend", ofType: "json")
        // 2 获取Json文件里面的内容，NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 解析
        let json = JSON(jsonData!)
        if let mappedOnject = JSONDeserializer<HM_AlbumsModel>.deserializeModelArrayFrom(json: json["data"]["albums"].description) {
            self.albums = mappedOnject as? [HM_AlbumsModel]
            self.updataBlock?()
        }
    }
}

extension HM_ListenRecommendViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albums?.count ?? 0
    }
}
