//
//  HM_VipHotCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_VipHotCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.numberOfLines = 0
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func setupView() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    
        self.addSubview(self.titleLable)
        self.titleLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    var categoryContentsModel:HM_CategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {
                return
            }
            self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLable.text = model.title
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
