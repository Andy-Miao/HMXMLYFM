//
//  HM_ListenFooterView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

protocol HM_ListenFooterViewDelegate: NSObjectProtocol {
    func listenFooterViewClick()
}

class HM_ListenFooterView: UIView {

    weak var delegate : HM_ListenFooterViewDelegate?
    
    private var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize:18)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
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
        self.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    
    var listenFooterViewTitle: String? {
        didSet{
            guard let title = listenFooterViewTitle else {
                return
            }
            addButton.setTitle(listenFooterViewTitle, for:.normal)
        }
    }
    @objc func addButtonAction() {
        delegate?.listenFooterViewClick()
    }

}
