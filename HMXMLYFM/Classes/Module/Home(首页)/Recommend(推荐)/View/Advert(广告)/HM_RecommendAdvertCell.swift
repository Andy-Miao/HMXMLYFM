//
//  HM_RecommendAdvertCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/28.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RecommendAdvertCell: UICollectionViewCell {
    // 图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private lazy var titileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label;
    }()
    // 子标题
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.imageView)
        self.addSubview(self.titileLabel)
        self.addSubview(self.subLabel)
    }
    
    var adModel:HM_RecommendAdvertModel? {
        didSet {
            self.imageView.image = UIImage(named: "fj.jpg")
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
            self.imageView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.bottom.equalToSuperview().offset(-60)
            }
            
            self.titileLabel.text = "那些事"
            self.titileLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.top.equalTo(self.imageView.snp.bottom)
                make.height.equalTo(30)
            }
            
            self.subLabel.text = "开年会发年终奖呀领导开年会发年终奖呀"
            self.subLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.top.equalTo(self.titileLabel.snp.bottom)
                make.height.equalTo(30)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    // 获取数据
    var advertModel:HM_RecommendAdvertModel? {
        didSet {
            guard  let model = advertModel else {
                return
            }
            self.titileLabel.text = model.name
            self.subLabel.text = model.description
        }
    }
}
