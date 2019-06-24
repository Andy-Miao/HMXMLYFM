//
//  HM_HomeVipEnjoyCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

protocol HM_HomeVipEnjoyCellDelegate:NSObjectProtocol {
    func homeVipEnjoyCellItemClick(model: HM_CategoryContents)
}

class HM_HomeVipEnjoyCell: UITableViewCell {

    weak var delegate : HM_HomeVipEnjoyCellDelegate?
    
    private var categroyContents:[HM_CategoryContents]?
    
    private let HM_VipEnjoyCellID = "HM_VipEnjoyCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HM_VipEnjoyCell.self, forCellWithReuseIdentifier: HM_VipEnjoyCellID)
        return  collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    func setupView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
    
    var categoryContentsModel:[HM_CategoryContents]? {
        didSet {
            guard let model = categoryContentsModel else {return}
            self.categoryContentsModel = model
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HM_HomeVipEnjoyCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HM_VipEnjoyCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_VipEnjoyCellID, for: indexPath) as! HM_VipEnjoyCell
        cell.categoryContentsModel = self.categoryContentsModel?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeVipEnjoyCellItemClick(model: (self.categoryContentsModel?[indexPath.row])!)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(SCREEN_WIDTH - 50) / 3,height:self.frame.size.height)
    }
    
}
