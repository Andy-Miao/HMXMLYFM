//
//  HM_HomeVipHotCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit


protocol HM_HomeVipHotCellDelegate: NSObjectProtocol {
    func homeVipHotCellItemClick(model: HM_CategoryContents)
}

class HM_HomeVipHotCell: UITableViewCell {

    weak var delegate: HM_HomeVipHotCellDelegate?
    
    private var categoryContents: [HM_CategoryContents]?
    
    private let HM_VipHotCellID = "HM_vipHotCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.alwaysBounceVertical = true
        collectionV.register(HM_VipHotCell.self, forCellWithReuseIdentifier: HM_VipHotCellID)
        return collectionV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
    
    var categoryContentsModel: [HM_CategoryContents]? {
        didSet {
            guard let model = categoryContentsModel else {
                return
            }
            self.categoryContents = model
            self.collectionView.reloadData()
        }
    }
}

extension HM_HomeVipHotCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    

    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HM_VipHotCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_VipHotCellID, for: indexPath) as! HM_VipHotCell
        cell.categoryContentsModel = self.categoryContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeVipHotCellItemClick(model:(self.categoryContents?[indexPath.row])!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 50)/3 , height: self.frame.size.height)
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}
