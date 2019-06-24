//
//  HM_VipCategoryCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/21.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_VipCategoryCell: UICollectionViewCell {
    
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var categoryBtnModel: HM_CategoryBtnModel? {
        didSet {
            guard let model = categoryBtnModel else { return }
            
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            self.titleLabel.text = model.title
        }
    }
}
