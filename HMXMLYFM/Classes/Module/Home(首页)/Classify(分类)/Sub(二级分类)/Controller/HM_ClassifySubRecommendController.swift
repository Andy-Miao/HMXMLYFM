//
//  HM_ClassifySubRecommendController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_ClassifySubRecommendController: HM_BasisViewController {
    // - 上页面传过来请求接口必须的参数
    private var categoryId: Int = 0
    convenience init(categoryId:Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    private let HM_ClassifySubHeaderViewID = "HM_ClassifySubHeaderView"
    private let HM_ClassifySubFooterViewID = "HM_ClassifySubFooterView"
    
    private let HM_ClassifySubHeaderCellID = "HM_ClassifySubHeaderCell"
    private let HM_ClassifySubHorizontalCellID = "HM_ClassifySubHorizontalCell"
    private let HM_ClassifySubVerticalCellID = "HM_ClassifySubVerticalCell"
    private let HM_ClassifySubModuleType20CellID = "HM_ClassifySubModuleType20Cell"
    private let HM_ClassifySubModuleType19CellID = "HM_ClassifySubModuleType19Cell"
    private let HM_ClassifySubModuleType17CellID = "HM_ClassifySubModuleType17Cell"
    private let HM_ClassifySubModuleType4CellID = "HM_ClassifySubModuleType4Cell"
    private let HM_ClassifySubModuleType16CellID = "HM_ClassifySubModuleType16Cell"
    private let HM_ClassifySubModuleType23CellID = "HM_ClassifySubModuleType23Cell"
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
        collection.register(HM_ClassifySubHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_ClassifySubHeaderViewID)
        collection.register(HM_ClassifySubFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_ClassifySubFooterViewID)
        
        // - 注册不同分区cell
        collection.register(HM_ClassifySubHeaderCell.self, forCellWithReuseIdentifier: HM_ClassifySubHeaderCellID)
        collection.register(HM_ClassifySubHorizontalCell.self, forCellWithReuseIdentifier: HM_ClassifySubHorizontalCellID)
        collection.register(HM_ClassifySubVerticalCell.self, forCellWithReuseIdentifier: HM_ClassifySubVerticalCellID)
        collection.register(HM_ClassifySubModuleType20Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType20CellID)
        collection.register(HM_ClassifySubModuleType19Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType19CellID)
        collection.register(HM_ClassifySubModuleType17Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType17CellID)
        collection.register(HM_ClassifySubModuleType4Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType4CellID)
        collection.register(HM_ClassifySubModuleType16Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType16CellID)
        collection.register(HM_ClassifySubModuleType23Cell.self, forCellWithReuseIdentifier: HM_ClassifySubModuleType23CellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadRecommendData() }
        
        return collection
    }()
    
    
    lazy var viewModel: HM_ClassifySubRecommendViewModel = {
        return HM_ClassifySubRecommendViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        loadRecommendData()
    }
    
    func loadRecommendData(){
        viewModel.categoryId = self.categoryId
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HM_ClassifySubRecommendController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardClass = viewModel.classifyCategoryContentsList?[indexPath.section].cardClass
        let moduleType = viewModel.classifyCategoryContentsList?[indexPath.section].moduleType
        if moduleType == 14 {
            let cell:HM_ClassifySubHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubHeaderCellID, for: indexPath) as! HM_ClassifySubHeaderCell
            cell.focusModel = viewModel.focus
            cell.classifyCategoryContentsListModel = viewModel.classifyCategoryContentsList?[indexPath.section]
            return cell
        }else if moduleType == 3 {
            if cardClass == "horizontal" {
                let cell:HM_ClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubHorizontalCellID, for: indexPath) as! HM_ClassifySubHorizontalCell
                cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }else {
                let cell:HM_ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubVerticalCellID, for: indexPath) as! HM_ClassifySubVerticalCell
                cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }
        }else if moduleType == 5{
            if cardClass == "horizontal" {
                let cell:HM_ClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubHorizontalCellID, for: indexPath) as! HM_ClassifySubHorizontalCell
                cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }else {
                let cell:HM_ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubVerticalCellID, for: indexPath) as! HM_ClassifySubVerticalCell
                cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }
        }else if moduleType == 20 {
            let cell:HM_ClassifySubModuleType20Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType20CellID, for: indexPath) as! HM_ClassifySubModuleType20Cell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 19 {
            let cell:HM_ClassifySubModuleType19Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType19CellID, for: indexPath) as! HM_ClassifySubModuleType19Cell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 17 {
            let cell:HM_ClassifySubModuleType17Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType17CellID, for: indexPath) as! HM_ClassifySubModuleType17Cell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 4 {
            let cell:HM_ClassifySubModuleType4Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType4CellID, for: indexPath) as! HM_ClassifySubModuleType4Cell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 16 {
            let cell:HM_ClassifySubModuleType16Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType16CellID, for: indexPath) as! HM_ClassifySubModuleType16Cell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 23{
            let cell:HM_ClassifySubModuleType23Cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubModuleType23CellID, for: indexPath) as! HM_ClassifySubModuleType23Cell
            //            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 18{
            let cell:HM_ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubVerticalCellID, for: indexPath) as! HM_ClassifySubVerticalCell
            cell.classifyVerticalModel = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else {
            let cell:HM_ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_ClassifySubVerticalCellID, for: indexPath) as! HM_ClassifySubVerticalCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row].albumId ?? 0
        let vc = HM_PlayDetailController(albumId:albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
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
            let headerView : HM_ClassifySubHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_ClassifySubHeaderViewID, for: indexPath) as! HM_ClassifySubHeaderView
            headerView.classifyCategoryContents = viewModel.classifyCategoryContentsList?[indexPath.section]
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : HM_ClassifySubFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_ClassifySubFooterViewID, for: indexPath) as! HM_ClassifySubFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
