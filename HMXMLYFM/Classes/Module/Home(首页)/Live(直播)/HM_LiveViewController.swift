//
//  HM_LiveViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

let HM_HomeLiveSectionGrid     = 0   // 分类section
let HM_HomeLiveSectionBanner   = 1   // 滚动图片section
let HM_HomeLiveSectionRank     = 2   // 排行榜section
let HM_HomeLiveSectionLive     = 3   // 直播section

class HM_LiveViewController: HM_BasisViewController {
    var lives:[HM_LivesModel]?
    
    private let HM_HomeLiveHeaderViewID = "HM_HomeLiveHeaderView"
    private let HM_HomeLiveGridCellID   = "HM_HomeLiveGridCell"
    private let HM_HomeLiveBannerCellID = "HM_HomeLiveBannerCell"
    private let HM_HomeLiveRankCellID   = "HM_HomeLiveRankCell"
    private let HM_HomeLiveCellID       = "HM_HomeLiveCell"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // 注册头视图和尾视图
        collection.register(HM_HomeLiveHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_HomeLiveHeaderViewID)
        // 注册不同分区cell
        collection.register(HM_HomeLiveCell.self, forCellWithReuseIdentifier: HM_HomeLiveCellID)
        collection.register(HM_HomeLiveGridCell.self, forCellWithReuseIdentifier:HM_HomeLiveGridCellID)
        collection.register(HM_HomeLiveBannerCell.self, forCellWithReuseIdentifier:HM_HomeLiveBannerCellID)
        collection.register(HM_HomeLiveRankCell.self, forCellWithReuseIdentifier:HM_HomeLiveRankCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadLiveData() }
        return collection
    }()
    
    lazy var viewModel: HM_HomeLiveViewModel = {
        return HM_HomeLiveViewModel()
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
        // 刚进页面进行刷新
        self.collectionView.uHead.beginRefreshing()
        loadLiveData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadLiveData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }

}

// - collectionviewDelegate
extension HM_LiveViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case HM_HomeLiveSectionGrid:
            let cell:HM_HomeLiveGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HomeLiveGridCellID, for: indexPath) as! HM_HomeLiveGridCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.delegate = self
            return cell
        case HM_HomeLiveSectionBanner:
            let cell:HM_HomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HomeLiveBannerCellID, for: indexPath) as! HM_HomeLiveBannerCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.bannerList = viewModel.homeLiveBanerList
            return cell
        case HM_HomeLiveSectionRank:
            let cell:HM_HomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HomeLiveRankCellID, for: indexPath) as! HM_HomeLiveRankCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.backgroundColor = UIColor.red
            cell.multidimensionalRankVos = viewModel.multidimensionalRankVos
            return cell
        default:
            let cell:HM_HomeLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HomeLiveCellID, for: indexPath) as! HM_HomeLiveCell
            cell.liveData = viewModel.lives?[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
    
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
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView: HM_HomeLiveHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_HomeLiveHeaderViewID, for: indexPath) as! HM_HomeLiveHeaderView
            
             headerView.delegate = self
            return headerView
            
        } else {
            return UICollectionReusableView()
        }
    }
}

// - 点击顶部分类按钮 delegate
extension HM_LiveViewController:HM_HomeLiveGridCellDelegate{
    func homeLiveGridCellItemClick(channelId: Int,title:String) {
        let vc = HM_LiveCategoryListController(channelId: channelId)
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// - 点击中间直播item上分类按钮 delegate
extension HM_LiveViewController:HM_HomeLiveHeaderViewDelegate{
    func homeLiveHeaderViewCategoryBtnClick(button: UIButton) {
        viewModel.categoryType = button.tag - 988
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshCategoryLiveData()
    }
}
