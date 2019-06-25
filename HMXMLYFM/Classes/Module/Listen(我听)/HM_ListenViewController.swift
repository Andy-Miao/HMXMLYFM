//
//  HM_ListenViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
//import LTScrollView

class HM_ListenViewController: HM_BasisViewController {

    // 头部 - headerView
    private lazy var headerView:HM_ListenHeaderView = {
        let view = HM_ListenHeaderView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:120))
        return view
    }()
    
    // 添加l控制器上部标题
    private lazy var titles: [String] = {
        return ["订阅", "一键听", "推荐"]
    }()
    
}
