//
//  HM_ForYouCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/23.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_ForYouCell: UICollectionViewCell {
    // 图片
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 标题
    private lazy var titleLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 17)
        return lable
    }()
    
    // 子标题
    private lazy var subLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        return lable
    }()
    
    // 子标题
    private lazy var numLabel : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subLabel)
        self.addSubview(self.numLabel)
        
        self.imageView.image = UIImage(named: "pic1.jpeg")
        self.titleLabel.text = "房价那些事"
        self.subLabel.text = "卖房子卖房子"
        self.numLabel.text = "> 2.5亿 1284集"
    }
    
    func  setupLayout() {
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.imageView)
            make.height.equalTo(20)
        }
        
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        self.numLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.subLabel)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
