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
                warningConfig.presentationContext = .window(windowLevel:UIWindow.Level.statusBar)
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
