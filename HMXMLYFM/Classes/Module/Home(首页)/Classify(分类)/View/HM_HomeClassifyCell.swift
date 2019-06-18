//
//  HM_HomeClassifyCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/4.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_HomeClassifyCell: UICollectionViewCell {
    
    lazy var imageV : UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    lazy var titleL : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds =  true
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        
        self.addSubview(self.imageV)
        self.imageV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleL)
        self.titleL.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageV.snp.right).offset(5)
            make.top.bottom.equalTo(self.imageV)
            make.width.equalToSuperview().offset(-self.imageV.frame.width)
        }
    }
    
    var itemModel:HM_ItemList? {
        didSet {
            guard let model = itemModel else { return }
            if model.itemType == 1 {// 如果是第一个item,是有图片显示的，并且字体偏小
                self.titleL.text = model.itemDetail?.keywordName
            }else{
                self.titleL.text = model.itemDetail?.title
                self.imageV.kf.setImage(with: URL(string: model.coverPath!))
            }
        }
    }
    
    // 前三个分区第一个item的字体较小
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2  {
                if indexPath.row == 0 {
                    self.titleL.font = UIFont.systemFont(ofSize: 13)
                }else {
                    self.imageV.snp.updateConstraints { (make) in
                        make.left.equalToSuperview()
                        make.width.equalTo(0)
                    }
                    self.titleL.snp.updateConstraints { (make) in
                        make.left.equalTo(self.imageV.snp.right)
                        make.width.equalToSuperview()
                    }
                    self.titleL.textAlignment = NSTextAlignment.center
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
