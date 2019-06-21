//
//  HM_RecommendHomeLiveCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/28.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


class HM_RecommendHomeLiveCell: UICollectionViewCell {
    
    private var live:[HM_LiveModel]?
    private let HM_RecommendLiveCellID = "HM_RecommendLiveCell"
    
    private lazy var changBtn:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(BTN_COLOR, for: .normal)
        button.backgroundColor = SYC_Tools.RGBColor(r: 254, g: 232, b: 227)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self , action: #selector(updataBtnClick(button:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionV = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.alwaysBounceVertical = true
        collectionV.register(HM_RecommendLiveCell.self, forCellWithReuseIdentifier: HM_RecommendLiveCellID)
        return  collectionV
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
//            make.left.top.equalTo(15)
//            make.bottom.equalToSuperview().offset(-50)
//            make.right.equalToSuperview().offset(-15)
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(15, 15, 50, 15))
        }
        
        self.addSubview(self.changBtn)
        self.changBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    @objc func updataBtnClick(button : UIButton){
        
        HM_RecommendProvider.request(.changeLiveList) { (result) in
            if  case let.success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 如果能解析出来，赋值 刷新
                if let mappedObject = JSONDeserializer<HM_LiveModel>.deserializeModelArrayFrom(json: json["data"]["list"].description) {
                    self.live = mappedObject as? [HM_LiveModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var liveList : [HM_LiveModel]? {
        didSet {
            guard let model = liveList  else {
                return;
            }
            
            self.live = model
            self.collectionView.reloadData()
        }
    }
}

extension HM_RecommendHomeLiveCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.live?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_RecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendLiveCellID, for: indexPath) as! HM_RecommendLiveCell
        cell.recommendLiveModel = self.live?[indexPath.row]
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(SCREEN_WIDTH - 55) / 3,height:180)
    }
}
