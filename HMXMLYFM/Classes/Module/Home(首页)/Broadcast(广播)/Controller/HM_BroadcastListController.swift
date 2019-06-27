//
//  HM_BroadcastListController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_BroadcastListController: HM_BasisViewController {

    private var topRadiosModel:[HM_TopRadiosModel]?
    private let HM_RadiosCellID = "HM_RadiosCell"
    
    // 外部传值请求接口
    private var url:String?
    private var categoryId = 0
    private var isMoreCategory:Bool = false
    convenience init(url:String?,categoryId:Int = 0,isMoreCategory:Bool = false) {
        self.init()
        self.url = url
        self.categoryId = categoryId
        self.isMoreCategory = isMoreCategory
    }
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // 注册不同分区cell
        collection.register(HM_RadiosCell.self, forCellWithReuseIdentifier:HM_RadiosCellID)
        
        if isMoreCategory{
            collection.uHead = URefreshHeader{ [weak self] in self?.loadMoreCategoryData() }
        }else{
            collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        }
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        if isMoreCategory{
            loadMoreCategoryData()
        }else{
            loadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        // 首页广播接口请求
        HM_HomeBrodcastAPIProvider.request(.categoryBroadcastList(path:self.url!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_TopRadiosModel>.deserializeModelArrayFrom(json: json["data"]["data"].description) {
                    self.topRadiosModel = mappedObject as? [HM_TopRadiosModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    func loadMoreCategoryData(){
        // 首页广播接口请求
        HM_HomeBrodcastAPIProvider.request(.moreCategoryBroadcastList(categroryId:self.categoryId)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_TopRadiosModel>.deserializeModelArrayFrom(json: json["data"]["data"].description) {
                    self.topRadiosModel = mappedObject as? [HM_TopRadiosModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }

}

// - collectionviewDelegate
extension HM_BroadcastListController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topRadiosModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_RadiosCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RadiosCellID, for: indexPath) as! HM_RadiosCell
        cell.topRadioModel = self.topRadiosModel?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:SCREEN_WIDTH,height:120)
    }
    
}
