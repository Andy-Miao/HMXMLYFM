//
//  HM_BasisNavigationController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/15.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_BasisNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupNavBarAppearence()
    }
    
    func setupNavBarAppearence() {
         // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor = SYC_Tools.RGBColor(r: 244, g: 244, b: 245)
         // 设置导航栏所有按钮的颜色
        WRNavigationBar.defaultNavBarTintColor = BTN_COLOR
        WRNavigationBar.defaultNavBarTitleColor = .black
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
        // 统一设置导航栏样式
        //        WRNavigationBar.defaultStatusBarStyle = .lightContent
    }
}

extension HM_BasisNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
