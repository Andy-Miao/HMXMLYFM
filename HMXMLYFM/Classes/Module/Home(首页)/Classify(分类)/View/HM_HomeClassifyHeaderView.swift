//
//  HM_HomeClassifyHeaderView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/4.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_HomeClassifyHeaderView: UICollectionReusableView {
    
    lazy var view : UIView = {
        let view = UIView()
        view.backgroundColor = BTN_COLOR
        return view
    }()
    
    lazy var titleL : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = DOWN_COLOR
        self.addSubview(self.view)
        self.view.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        
        self.addSubview(self.titleL)
        self.titleL.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    var titleStr : String? {
        didSet {
            guard let str = titleStr  else {
                return;
            }
            self.titleL.text = str;
        }
    }
}
