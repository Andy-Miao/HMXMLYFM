//
//  HM_HomeClassifyViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_HomeClassifyViewModel: NSObject {

    var classifyModel: [HM_ClassifyModel]?
    // - 数据更新
    typealias HM_AddDataBlock = () -> Void
    var updataBlock: HM_AddDataBlock?
    
    
}

extension HM_HomeClassifyViewModel {
    
    // 请求首页分类接口
    func refreshDataSource() {
        HM_HomeClassifyProvider.request(.classifyList) { (result) in
            if  case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_HomeClassifyModel>.deserializeFrom(json: json.description) {
                    self.classifyModel = mappedObject.list
                }
                // 刷新数据
                self.updataBlock?()
            }
        }
    }
}

extension HM_HomeClassifyViewModel {
    
    func numberOfSections(collection:UICollectionView) -> Int {
        return self.classifyModel?.count ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    
    // 每个分区的内边距
    func insetForSectionAt(section: NSInteger) ->UIEdgeInsets {
        return UIEdgeInsetsMake(0, 2.5, 0, 2.5)
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section: NSInteger) -> CGFloat {
        return 0
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section: NSInteger) -> CGFloat {
        return 2;
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width: (SCREEN_WIDTH - 10)/4.0, height: 40)
        }
        
        return CGSize.init(width: (SCREEN_WIDTH - 7.5)/3.0, height: 40)
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if  section == 0 || section == 1 || section == 2 {
            return .zero
        }
        
        return CGSize(width: SCREEN_HEIGHT, height: 30)
    }
    
    // 分区尾视图
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height:8.0)
    }

}
