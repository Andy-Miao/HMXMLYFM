//
//  HM_LiveRankCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_LiveRankCell: UICollectionViewCell {
    
    private lazy var imageView : UIView = {
        let imageView = UIView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(180)
        }
        
        self.imageView.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var multidimensionalRankVos: HM_MultidimensionalRankVosModel? {
        didSet {
            guard let model = multidimensionalRankVos else {
                return
            }
            self.titleLabel.text = model.dimensionName
            let num: Int = (model.ranks?.count)!
            let margin:Int = 50
            for index in 0..<num {
                let picView = UIImageView(frame: CGRect(x: margin*index+5*index , y: 5, width: margin, height: margin))
                picView.layer.masksToBounds = true
                picView.layer.cornerRadius = picView.frame.size.width/2.0
                picView.kf.setImage(with: URL(string: (model.ranks?[index].coverSmall)!)!)
                self.imageView.addSubview(picView)
            }
        }
        
    }
    
}
