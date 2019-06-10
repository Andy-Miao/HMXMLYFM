//
//  HM_RecommendOneKeyListenCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/28.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RecommendOneKeyListenCell: UICollectionViewCell {
    
    private var oneKeyListen:[HM_OneKeyListenModel]?
    private let HM_OnekeyListenCellID = "HM_OnekeyListenCell"
    private lazy var changeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(BTN_COLOR, for: .normal)
        button.backgroundColor = SYC_Tools.RGBColor(r: 254, g: 232, b: 227)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 45)/3, height: 120)
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HM_OneKeyListenCell.self, forCellWithReuseIdentifier: HM_OnekeyListenCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var oneKeyListenList:[HM_OneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            self.oneKeyListen = model;
            self.gridView.reloadData()
        }
    }
    
    @objc func updataBtnClick( button: UIButton) {
        
    }
}

extension HM_RecommendOneKeyListenCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HM_OneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier:HM_OnekeyListenCellID, for: indexPath) as! HM_OneKeyListenCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }
    
    
}
