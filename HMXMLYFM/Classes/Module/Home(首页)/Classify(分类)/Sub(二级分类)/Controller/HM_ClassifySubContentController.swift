//
//  HM_ClassifySubContentController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HM_ClassifySubContentController: HM_BasisViewController {
    // - 上页面传过来请求接口必须的参数
    private var keywordId: Int = 0
    private var categoryId: Int = 0
    convenience init(keywordId: Int = 0, categoryId:Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    // - 定义接收的数据模型
    private var classifyVerticallist:[HM_ClassifyVerticalModel]?
    
    private let HM_ClassifySubVerticalCellID = "HM_ClassifySubVerticalCell"
    
    // - 懒加载
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:SCREEN_WIDTH - 15, height:120)
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册不同分区cell
        collection.register(HM_ClassifySubVerticalCell.self, forCellWithReuseIdentifier: HM_ClassifySubVerticalCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.top.bottom.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData(){
        // 分类二级界面其他分类接口请求
        HM_ClassifySubMenuProvider.request(HM_ClassifySubMenuAPI.classifyOtherContentList(keywordId:self.keywordId,categoryId:self.categoryId)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_ClassifyVerticalModel>.deserializeModelArrayFrom(json:json["list"].description) {
                    self.classifyVerticallist = mappedObject as? [HM_ClassifyVerticalModel]
                    self.collectionView.uHead.endRefreshing()
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HM_ClassifySubContentController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyVerticallist?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubVerticalCellID, for: indexPath) as! HM_ClassifySubVerticalCell
        cell.classifyVerticalModel = self.classifyVerticallist?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = self.classifyVerticallist?[indexPath.row].albumId ?? 0
        let vc = HM_PlayViewController(albumId:albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

