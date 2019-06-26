//
//  HM_ListenViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_ListenViewController: HM_BasisViewController {

    // 头部 - headerView
    private lazy var headerView:HM_ListenHeaderView = {
        let view = HM_ListenHeaderView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:120))
        return view
    }()
    
    private lazy var viewContorllers: [UIViewController] = {
        let listenSubscibeVC = HM_ListenSubscibeController()
        let listenChannelVC = HM_ListenChannelController()
        let listenRecommendVC = HM_ListenRecommendController()
        return [listenSubscibeVC, listenChannelVC, listenRecommendVC]
    }()
    
    // 添加l控制器上部标题
    private lazy var titles: [String] = {
        return ["订阅", "一键听", "推荐"]
    }()
    
    lazy var leftBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "msg"), for: .normal)
        button.addTarget(self , action: #selector(leftBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "搜索"), for: .normal)
        button.addTarget(self , action: #selector(rightBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    @objc func leftBarButtonClick() {
        print("左边按钮被点击了")
    }
    
    @objc func rightBarButtonClick() {
        print("右边按钮被点击了")
    }
    
    private lazy var layout: LTLayout = {
      let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = .white
        layout.titleColor = SYC_Tools.RGBColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = SYC_Tools.RGBColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = .red
        layout.sliderHeight = 56
         /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT), viewControllers: viewContorllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { () -> UIView in
            return headerView
//            [weak self] in
//            guard let strongSelf = self else { return UIView() }
//            let headerView = strongSelf.headerView
//            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        // advancedManager.hoverY = - LBFMNavBarHeight
        /* 点击切换滚动过程动画 */
        // advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        // advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(self.advancedManager)
        advancedManagerCongig()
    }
}

extension HM_ListenViewController: LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerCongig() {
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}
