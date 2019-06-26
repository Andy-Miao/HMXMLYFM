//
//  HM_OneKeyListenLTCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit


class HM_OneKeyListenLTCell: UITableViewCell {

    // 竖线
    var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = BTN_COLOR
        view.isHidden = true
        return view
    }()
    // 名字
    var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(4)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.left.equalTo(self.lineView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    var channelClassInfo: HM_ChannelClassInfoModel? {
        didSet {
            guard let model = channelClassInfo else {return}
            self.titleLabel.text = model.className
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
