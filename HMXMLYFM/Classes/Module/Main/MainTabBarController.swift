//
//  MainTabBarController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages

class MainTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
        
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupConfig() {
        self.delegate = self as? UITabBarControllerDelegate
        self.title = "Irregularity"
        self.tabBar.shadowImage = UIImage(named: "transparent")
        self.shouldHijackHandler = {
            tabBarController,viewController,index in
            if index == 2 {
                return true
            }
            return false
        }
        
        self.didHijackHandler = {
            tabBarController,viewController,index in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                warning.configureContent(title: "Warning", body: "暂是没有此功能", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            })
        }
    }

    func setupView() {
        
        let home = HM_HomeViewController()
        let listen = HM_ListenViewController()
        let paly = HM_PlayViewController()
        let find = HM_FindViewController()
        let mine = HM_MineViewController()
        
        home.tabBarItem = ESTabBarItem.init(HM_BasisTabBarItem(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        listen.tabBarItem = ESTabBarItem.init(HM_BasisTabBarItem(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        paly.tabBarItem = ESTabBarItem.init(HM_BasisTabBarItem(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        find.tabBarItem = ESTabBarItem.init(HM_BasisTabBarItem(), title: "发现", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        mine.tabBarItem = ESTabBarItem.init(HM_BasisTabBarItem(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        
        let homeNav = HM_BasisNavigationController(rootViewController: home)
        let listenNav = HM_BasisNavigationController(rootViewController: listen)
        let palyNav = HM_BasisNavigationController(rootViewController: paly)
        let findNav = HM_BasisNavigationController(rootViewController: find)
        let mineNav = HM_BasisNavigationController(rootViewController: mine)
        
        home.title = "首页"
        listen.title = "我听"
        paly.title = "播放"
        find.title = "发现"
        mine.title = "我的"
        
        self.viewControllers = [homeNav, listenNav, palyNav, findNav, mineNav]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
