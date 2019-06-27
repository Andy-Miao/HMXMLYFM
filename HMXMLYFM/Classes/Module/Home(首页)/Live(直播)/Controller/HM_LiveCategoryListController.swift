//
//  HM_LiveCategoryListController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_LiveCategoryListController: HM_BasisViewController {
    private var liveList:[HM_LivesModel]?
    private let HM_RecommendLiveCellID = "HM_RecommendLiveCell"
    
    // 外部传值请求接口如此那
    private var channelId = 0
    convenience init(channelId:Int = 0) {
        self.init()
        self.channelId = channelId
    }
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // - 注册不同分区cell
        collection.register(HM_RecommendLiveCell.self, forCellWithReuseIdentifier:HM_RecommendLiveCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        self.collectionView.uHead.beginRefreshing()
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        // 首页广播接口请求
        HM_HomeLiveAPIProvider.request(.categoryLiveList(channelId:self.channelId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_LivesModel>.deserializeModelArrayFrom(json: json["data"]["homePageVo"]["lives"].description) {
                    self.liveList = mappedObject as? [HM_LivesModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
}

// - collectionviewDelegate
extension HM_LiveCategoryListController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.liveList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_RecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendLiveCellID, for: indexPath) as! HM_RecommendLiveCell
        cell.liveModel = self.liveList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(SCREEN_WIDTH - 40)/2,height:230)
    }
}
