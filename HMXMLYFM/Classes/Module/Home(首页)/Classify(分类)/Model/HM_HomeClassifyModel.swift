//
//  HM_HomeClassifyModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import HandyJSON
import Foundation

struct HM_HomeClassifyModel: HandyJSON {
    var list:[HM_ClassifyModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}

struct HM_ClassifyModel: HandyJSON {
    var groupName : String?
    var displayStyleType: Int = 0
    var itemList: [HM_ItemList]?
}

struct HM_ItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: HM_ItemDetail?
}

struct HM_ItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}
