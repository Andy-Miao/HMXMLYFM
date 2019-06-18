

//
//  HM_ClassifyViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_ClassifyViewController: HM_BasisViewController {
    
    private let HM_HomeClassifyCellID = "HM_HomeClassifyCell"
    private let HM_HomeClassifyFooterViewID = "HM_HomeClassifyFooterView"
    private let HM_HomeClassifyHeaderViewID = "HM_HomeClassifyHeaderView"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(HM_HomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_HomeClassifyFooterViewID)
        collection.register(HM_HomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,  withReuseIdentifier: HM_HomeClassifyHeaderViewID)
        collection.backgroundColor = DOWN_COLOR
        return  collection
    }()
    
    lazy var viewModel: HM_HomeClassifyViewModel = {
        
        return HM_HomeClassifyViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.view.backgroundColor = .clear
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.height.equalToSuperview();
        }
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        viewModel.updataBlock = {
            [unowned self ] in
            self.collectionView.reloadData()
        }
        
        viewModel.refreshDataSource()
    }
    
}

extension HM_ClassifyViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier:String = "\(indexPath.section)\(indexPath.row)"
        self.collectionView.register(HM_HomeClassifyCell.self, forCellWithReuseIdentifier: identifier)
        let cell: HM_HomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HM_HomeClassifyCell
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 获取类别id跳转到子类
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView: HM_HomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_HomeClassifyHeaderViewID, for: indexPath) as! HM_HomeClassifyHeaderView
            return headerView
        } else if kind == UICollectionElementKindSectionFooter {
            let footerView :HM_HomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_HomeClassifyFooterViewID, for: indexPath) as! HM_HomeClassifyFooterView
            return footerView
        }
        
        return UICollectionReusableView()
        
    }
    
}
