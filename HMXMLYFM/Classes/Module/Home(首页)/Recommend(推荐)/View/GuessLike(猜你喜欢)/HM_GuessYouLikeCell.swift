//
//  HM_GuessYouLikeCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/22.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_GuessYouLikeCell: UICollectionViewCell {
   // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    private lazy var subLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = .gray
        lable.numberOfLines = 0
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
        self.addSubview(self.titleLable)
        self.addSubview(self.subLable)
    }
    
    func setupLayout() {
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.subLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLable.snp.bottom)
//            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommendData: HM_RecommendListModel? {
        didSet{
            guard let model = recommendData else {
                return
            }
            self.titleLable.text = model.title
            self.subLable.text = model.subtitle
            guard (model.pic != nil) else {
                return
            }
            self.imageView.kf.setImage(with: URL(string: model.pic!))
        }
    }
    
}
