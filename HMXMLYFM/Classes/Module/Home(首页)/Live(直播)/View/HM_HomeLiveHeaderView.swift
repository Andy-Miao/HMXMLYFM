//
//  HM_HomeLiveHeaderView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

/// 添加cell点击代理方法
protocol HM_HomeLiveHeaderViewDelegate:NSObjectProtocol {
    func homeLiveHeaderViewCategoryBtnClick(button:UIButton)
}

class HM_HomeLiveHeaderView: UICollectionReusableView {
    weak var delegate : HM_HomeLiveHeaderViewDelegate?

    private var btnArray = NSMutableArray()
    private var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = BTN_COLOR
        return view
    }()
    private var moreBtn: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("更多 >", for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.addTarget(self, action: #selector(moreBtnClick), for: UIControlEvents.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        let num = ["热门","情感","有声","新秀","二次元"]
        let margin:CGFloat = 50
        for index in 0..<num.count {
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.frame = CGRect(x:margin*CGFloat(index),y:2.5,width:margin,height:25)
            btn.setTitle(num[index], for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            btn.tag = index+1000
            if btn.tag == 1000 {
                btn.setTitleColor(BTN_COLOR, for: UIControlState.normal)
                self.lineView.frame = CGRect(x:margin * CGFloat(btn.tag - 1000)+12.5,y:30,width:margin/2,height:2)
            }else {
                btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            }
            self.btnArray.add(btn)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(btn)
        }
        
        self.addSubview(self.lineView)
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.top.equalTo(2.5)
        }
        
    }
    @objc func btnClick(button:UIButton) {
        let margin:CGFloat = 50
        self.lineView.frame = CGRect(x:margin*CGFloat(button.tag-1000)+12.5,y:30,width:margin/2,height:2)
        for btn in self.btnArray {
            if (btn as AnyObject).tag == button.tag {
                (btn as AnyObject).setTitleColor(BTN_COLOR, for: UIControlState.normal)
            }else {
                (btn as AnyObject).setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            }
        }
        delegate?.homeLiveHeaderViewCategoryBtnClick(button: button)
    }
    
    @objc func moreBtnClick(){
        
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "暂时没有此功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
