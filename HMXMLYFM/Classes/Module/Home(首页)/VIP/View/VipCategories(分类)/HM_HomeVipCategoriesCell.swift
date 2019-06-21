//
//  HM_HomeVipCategoriesCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/21.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

protocol HM_HomeVipCategoriesCellDelegate:NSObjectProtocol {
    func homeVipCategoriesCellItemClick(id:String,url:String,title:String)
}

class HM_HomeVipCategoriesCell: UITableViewCell {
    weak var delegate: HM_HomeVipCategoriesCellDelegate?
    
    private var categoryBtnList: [HM_CategoryBtnModel]?
    
    let HM_VipCategoryCellID = "HM_VipCategoryCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: SCREEN_WIDTH / 5.0, height: 80)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.contentSize = CGSize(width: SCREEN_WIDTH, height: 80)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(HM_VipCategoryCell.self, forCellWithReuseIdentifier: HM_VipCategoryCellID)
        return collectionV
    }()
    
    var categorBtnModel: [HM_CategoryBtnModel]? {
        didSet {
            
            guard let model = categorBtnModel  else {
                return
            }
            self.categoryBtnList = model
            self.collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.height.width.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HM_HomeVipCategoriesCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryBtnList?.count ?? 0
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HM_VipCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_VipCategoryCellID, for: indexPath) as! HM_VipCategoryCell
        cell.categoryBtnModel = self.categoryBtnList[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = self.categoryBtnList?[indexPath.row].properties?.uri else {
            let id = "0"
            let url = self.categoryBtnList?[indexPath.row].url ?? ""
            delegate?.homeVipCategoriesCellItemClick(id: id, url: url, title: self.categoryBtnList?[indexPath.row].title!)
            return
        }
        let id  = get
    }
    
    func getUrlCategoryId(url:String) -> String {
        // 判断是否有参数
        if !url.contains("?") {
            return ""
        }
        
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断是多参数还是单参数
        if string.contains("&") {
            // 多参数， 分割参数
            let urlComponents = string.split(separator: "&")
            for keyValuePair in urlComponents {
                // 分割key value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单参数
            let pairComponents = string.split(separator: "=")
            
            if pairComponents.count == 1 {
                return "nil"
            }
            
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value as AnyObject
        }
        return params["category_id"] as! String
    }
}
