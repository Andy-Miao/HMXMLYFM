//
//  HM_RecommendHotAudioBookCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/23.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

protocol HM_RecommendHotAudioBookCellDelegate:NSObjectProtocol {
    func recommendHotAudioBookCellCilck(model:HM_RecommendListModel)
}
class HM_RecommendHotAudioBookCell: UICollectionViewCell {
    weak var delegate : HM_RecommendHotAudioBookCellDelegate?
    
    private var recommendList:[HM_RecommendListModel]?
    
    private let HM_HotAudioBookCellID = "HM_HotAudioBookCell"
    
    private lazy var changBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(BTN_COLOR, for: .normal)
        button.backgroundColor = SYC_Tools.RGBColor(r: 254, g: 232, b: 227)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionV = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.alwaysBounceVertical = true
        collectionV.register(HM_HotAudioBookCell.self, forCellWithReuseIdentifier: HM_HotAudioBookCellID)
        return  collectionV
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
        self.addSubview(self.changBtn)
        self.addSubview(self.collectionView)
    }
    
    func setupLayout(){
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.changBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    // 赋值
    var recommendListData:[HM_RecommendListModel]? {
        didSet {
            guard let model = recommendListData else {
                return
            }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    
  
}

extension HM_RecommendHotAudioBookCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HM_HotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HotAudioBookCellID, for: indexPath) as! HM_HotAudioBookCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendHotAudioBookCellCilck(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:SCREEN_WIDTH - 30,height:120)
    }
}
