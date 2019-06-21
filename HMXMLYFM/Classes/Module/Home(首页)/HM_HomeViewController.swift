//
//  HM_HomeViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import DNSPageView

class HM_HomeViewController: HM_BasisViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        
        let pageStyle = DNSPageStyle()
        // 视图不能滑动
        pageStyle.isTitleViewScrollEnabled = false
        // 标题可缩放
        pageStyle.isTitleScaleEnabled = true
        pageStyle.isShowBottomLine = true
        pageStyle.titleSelectedColor = .black
        pageStyle.titleColor = .gray
        pageStyle.bottomLineColor = BTN_COLOR
        pageStyle.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let vcs : [UIViewController] = [HM_RecommendViewController(), HM_ClassifyViewController(), HM_VipViewController(), HM_LiveViewController(), HM_BroadcastViewController()]
        for vc in vcs {
            self.addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT - 44), style: pageStyle, titles: titles, childViewControllers: vcs)
        pageView.contentView.backgroundColor = .red
        view.addSubview(pageView)
    }
}
