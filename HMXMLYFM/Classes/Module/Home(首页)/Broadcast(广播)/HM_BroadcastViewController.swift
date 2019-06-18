//
//  HM_BroadcastViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

let HM_HomeBroadcastSectionTel     = 0   // 电台section
let HM_HomeBroadcastSectionMoreTel = 1   // 可展开电台section
let HM_HomeBroadcastSectionLocal   = 2   // 本地section
let HM_HomeBroadcastSectionRank    = 3   // 排行榜section

class HM_BroadcastViewController: HM_BasisViewController {

    private let HM_RadioHeaderViewID = "HM_RadioHeaderView"
    private let HM_RadioFooterViewID = "HM_RadioFooterView"
    private let HM_RadiosCellID = "HM_RadiosCell"
    private let HM_RadioCategoriesCellID = "HM_RadioCategoriesCell"
    private let HM_RadioSquareResultsCellID   = "HM_RadioSquareResultsCell"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // MARK -注册头视图和尾视图
        collection.register(HM_RadioHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_RadioHeaderViewID)
        collection.register(HM_RadioFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_RadioFooterViewID)
        // 注册不同分区cell
        collection.register(HM_RadiosCell.self, forCellWithReuseIdentifier:HM_RadiosCellID)
        collection.register(HM_RadioSquareResultsCell.self, forCellWithReuseIdentifier:HM_RadioSquareResultsCellID)
        
        collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return collection
    }()
    
    lazy var viewModel: HM_HomeBroadcastViewModel = {
        return HM_HomeBroadcastViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}
    // collectionviewDelegate
extension HM_BroadcastViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 4
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfItemsIn(section: section)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case HM_HomeBroadcastSectionTel: // 顶部电台
                let cell:HM_RadioSquareResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RadioSquareResultsCellID, for: indexPath) as! HM_RadioSquareResultsCell
                cell.radioSquareResultsModel = viewModel.radioSquareResults
                cell.delegate = self
                return cell
            case HM_HomeBroadcastSectionMoreTel: // 可展开更多的电台
                let identifier:String = "\(indexPath.section)\(indexPath.row)"
                self.collectionView.register(HM_RadioCategoriesCell.self, forCellWithReuseIdentifier: identifier)
                let cell:HM_RadioCategoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HM_RadioCategoriesCell
                cell.backgroundColor = UIColor.init(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
                cell.dataSource = viewModel.categories?[indexPath.row].name
                cell.layer.masksToBounds = true
                cell.layer.cornerRadius = 2
                return cell
            default:
                let cell:HM_RadiosCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RadiosCellID, for: indexPath) as! HM_RadiosCell
                if indexPath.section == HM_HomeBroadcastSectionLocal { // 本地电台
                    cell.localRadioModel = viewModel.localRadios?[indexPath.row]
                }else {
                    cell.topRadioModel = viewModel.topRadios?[indexPath.row]
                }
                return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if indexPath.section == 1 {
//                if indexPath.row == 7 {
//                    if viewModel.isUnfold {
//                        let categoryId:Int = (viewModel.categories?[indexPath.row].id)!
//                        let title = viewModel.categories?[indexPath.row].name
//                        let vc = HM_BroadcastListController(url: nil, categoryId: categoryId,isMoreCategory:true)
//                        vc.title = title
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }else {
//                        viewModel.isUnfold = true
//                        viewModel.categories?.remove(at: 7)
//                        viewModel.categories?.insert(viewModel.coverModel, at: 14)
//                        self.collectionView.reloadData()
//                    }
//                }else if indexPath.row == 15{
//                    if viewModel.isUnfold{
//                        viewModel.isUnfold = false
//                        viewModel.categories?.remove(at: 14)
//                        viewModel.categories?.insert(viewModel.bottomModel, at: 7)
//                        self.collectionView.reloadData()
//                    }else {
//
//                    }
//                }else{
//                    let categoryId:Int = (viewModel.categories?[indexPath.row].id)!
//                    let title = viewModel.categories?[indexPath.row].name
//                    let vc = HM_BroadcastListController(url: nil, categoryId: categoryId,isMoreCategory:true)
//                    vc.title = title
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }


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
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionElementKindSectionHeader {
                let headerView :HM_RadioHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_RadioHeaderViewID, for: indexPath) as! HM_RadioHeaderView
                headerView.backgroundColor = UIColor.white
                headerView.titleStr = viewModel.titleArr[indexPath.section - 2]
                return headerView
            }else {
                let footerView :HM_RadioFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_RadioFooterViewID, for: indexPath) as! HM_RadioFooterView
                return footerView
                
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return viewModel.referenceSizeForFooterInSection(section: section)
        }
}


// 点击最上层电台分类 Delegate
extension HM_BroadcastViewController:HM_RadioSquareResultsCellDelegate {
    
    func radioSquareResultsCellItemClick(url: String,title:String) {
        if title == "主播直播" {
//            let vc = HM_HomeLiveController()
//            vc.title = title
//            self.navigationController?.pushViewController(vc, animated: true)
        }else if title == "省市台"{

        }else {
            // 截取参数
//            var split = url.components(separatedBy: ".com")
//            let string = split[1]
//            let vc = HM_BroadcastListController(url: string, categoryId: 0,isMoreCategory:false)
//            vc.title = title
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
