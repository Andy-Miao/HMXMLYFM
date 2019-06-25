//
//  HM_ListenHeaderView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_ListenHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func setupView() {
        let  downView = UIView()
        downView.backgroundColor = DOWN_COLOR
        self.addSubview(downView)
        downView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let margin:CGFloat = self.frame.width/8
        let titleArray = ["下载", "历史", "已购", "喜欢"]
        let imageArray = ["下载","历史","购物车","喜欢"]
        let numArray = ["暂无","8","暂无","25"]
        for index in 0..<4 {
            let button = UIButton(frame: CGRect(x:margin*CGFloat(index)*2+margin/2,y:10,width:margin,height:margin))
            button.setImage(UIImage(named: imageArray[index]), for: .normal)
            self.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            titleLabel.textColor = .gray
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+20)
                make.top.equalTo(margin+10+25)
            }
            
            let numLabel = UILabel()
            numLabel.textAlignment = .center
            numLabel.text = numArray[index]
            numLabel.font = UIFont.systemFont(ofSize: 14)
            numLabel.textColor = .gray
            self.addSubview(numLabel)
            numLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+20)
                make.top.equalTo(margin+10+25)
            }
            
            button.tag = index
            button.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func click(sender:UIButton) {
        print("button 点击了")
    }
}
