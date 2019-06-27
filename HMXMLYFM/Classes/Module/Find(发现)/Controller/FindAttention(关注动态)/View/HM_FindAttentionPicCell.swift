//
//  HM_FindAttentionPicCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_FindAttentionPicCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 布局
        setupView()
    }
    // 布局
    func setupView() {
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 5
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var picModel :HM_FindAPicInfos? {
        didSet {
            guard let model = picModel else {return}
            self.imageView.kf.setImage(with: URL(string:model.originUrl! ))
        }
    }
}
