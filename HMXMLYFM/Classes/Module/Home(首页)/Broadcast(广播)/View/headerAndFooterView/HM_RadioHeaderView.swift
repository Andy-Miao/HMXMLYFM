//
//  HM_RadioHeaderView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/18.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RadioHeaderView: UICollectionReusableView {
    
    private var titleL: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        return lable
    }()
    
    private var moreBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
    
        self.addSubview(self.titleL)
        self.titleL.text = "最热有声读物"
        self.titleL.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(15)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    var titleStr: String? {
        didSet {
            guard let string = titleStr  else {
                return
            }
           self.titleL.text = string
        }
    }
}
