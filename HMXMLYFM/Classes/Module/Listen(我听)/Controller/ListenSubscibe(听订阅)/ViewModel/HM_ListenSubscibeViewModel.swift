
//
//  HM_ListenSubscibeViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
// - 数据源更新
typealias HM_AddDataBlock = () ->Void

class HM_ListenSubscibeViewModel: NSObject {
    var albumResults:[HM_AlbumResultsModel]?
    var updataBlock:HM_AddDataBlock?
}

extension HM_ListenSubscibeViewModel {
    
    func refreshDataSource() {
        // 1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenSubscibe", ofType: "json")
        // 2 获取Json文件里面的内容，NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 解析
        let json = JSON(jsonData!)
        if let mappedOnject = JSONDeserializer<HM_AlbumResultsModel>.deserializeModelArrayFrom(json: json["data"]["albumResults"].description) {
            self.albumResults = mappedOnject as? [HM_AlbumResultsModel]
            self.updataBlock?()
        }
    }
}

extension HM_ListenSubscibeViewModel {
    // - 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albumResults?.count ?? 0
    }
}
