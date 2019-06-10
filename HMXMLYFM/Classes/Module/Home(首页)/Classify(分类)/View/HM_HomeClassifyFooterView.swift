//
//  HM_HomeClassifyFooterView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/4.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_HomeClassifyFooterView: UICollectionReusableView {
    
    private lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = BTN_COLOR
        return view
    }()
    
    private lazy var titleL : UILabel = {
        let titleL = UILabel()
        titleL.textColor = .gray
        return titleL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        self.backgroundColor = DOWN_COLOR
        self.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(6, 10, 6, SCREEN_WIDTH - 10))
        }
        
        self.addSubview(self.titleL)
        self.titleL.snp.makeConstraints { (make) in
            make.left.equalTo(self.bgView.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
        
        var titleStr : String? {
            didSet {
                guard let str = titleStr  else {
                    return
                }
                self.titleL.text = str
            }
        }
    }
}
