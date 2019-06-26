//
//  HM_ListenChannelViewModel.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HM_ListenChannelViewModel: NSObject {
    var channelResults:[HM_ChannelResultsModel]?
    typealias HM_AddDataBlock = () ->Void
    // - 数据源更新
    var updataBlock:HM_AddDataBlock?
}

extension HM_ListenChannelViewModel {
    func refreshDataSource() {
        // 一键听接口请求
        HM_ListenAPIProvider.request(.listenChannelList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description) {
                    self.channelResults = mappedObject as? [HM_ChannelResultsModel]
                    self.updataBlock?()
                }
            }
        }
    }
}

extension HM_ListenChannelViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.channelResults?.count ?? 0
    }
}
