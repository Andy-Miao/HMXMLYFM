//
//  HM_FindRecommendPicCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_FindRecommendPicCell: UICollectionViewCell {
    
    // view
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 5
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // data
    var picModel:HM_FindRPicUrls? {
        didSet {
            guard let model = picModel else {return}
            self.imageView.kf.setImage(with: URL(string:model.originUrl! ))
        }
    }
}
