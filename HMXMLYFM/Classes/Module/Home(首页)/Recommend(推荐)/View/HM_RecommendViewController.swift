//
//  HM_RecommendViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RecommendViewController: HM_BasisViewController {

    private let HM_RecommendHeaderViewID = "HM_RecommendHeaderView"
    private let HM_RecommendFooterViewID = "HM_RecommendFooterView"
    // 注册不同的cell
    private let HM_RecommendHeaderCellID     = "HM_RecommendHeaderCell"
    // 猜你喜欢
    private let HM_RecommendGuessLikeCellID  = "HM_RecommendGuessLikeCell"
    // 热门有声书
    private let HM_RecommendHotAudioBookCellID = "HM_RecommendHotAudioBookCell"
    // 为你推荐
    private let HM_RecommendForYouCellID     = "HM_RecommendForYouCell"

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self 
        collection.dataSource = self
        collection.backgroundColor = .white
         // - 注册头视图和尾视图
        collection.register(HM_RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_RecommendHeaderViewID)
        collection.register(HM_RecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_RecommendFooterViewID)
        
        // - 注册不同分区cell
        // 默认
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(HM_RecommendHeaderCell.self, forCellWithReuseIdentifier: HM_RecommendHeaderCellID)
        // 猜你喜欢
        collection.register(HM_RecommendGuessLikeCell.self, forCellWithReuseIdentifier: HM_RecommendGuessLikeCellID)
        // 热门有声书
        collection.register(HM_RecommendHotAudioBookCell.self, forCellWithReuseIdentifier: HM_RecommendHotAudioBookCellID)
        
        // 为你推荐
        collection.register(HM_RecommendForYouCell.self, forCellWithReuseIdentifier: HM_RecommendForYouCellID)
        
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    lazy var viewModel: HM_RecommendViewModel = {
        return HM_RecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
       
        setupLoadData()
        // Do any additional setup after loading the view.
    }
    // 创建视图
    func setupView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
    }
    // 加载数据
    func setupLoadData() {
        viewModel.updateDataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HM_RecommendViewController :  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.numberOfItemsIn(section: section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let moduleType = viewModel.homeRecommendListModel?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:HM_RecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendHeaderCellID, for: indexPath) as! HM_RecommendHeaderCell
            cell.focusModel = viewModel.focusModel
            cell.squareList = viewModel.squareListModel
            cell.topBuzzListData = viewModel.topBuzzListmodel
            cell.delegate = self
            return cell
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" {
            let cell:HM_RecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendGuessLikeCellID, for: indexPath) as! HM_RecommendGuessLikeCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendListModel?[indexPath.section].list
            return  cell
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
            let cell:HM_RecommendHotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendHotAudioBookCellID, for: indexPath) as! HM_RecommendHotAudioBookCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendListModel?[indexPath.section].list
            return cell
        } else {
            let cell:HM_RecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_RecommendForYouCellID, for: indexPath) as! HM_RecommendForYouCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // 最小item间距
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
        let moduleType = viewModel.homeRecommendListModel?[indexPath.section].moduleType
        if kind == UICollectionElementKindSectionHeader {
            let headerView : HM_RecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_RecommendHeaderViewID, for: indexPath) as! HM_RecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendListModel?[indexPath.section]
            // 分区头右边更多按钮点击跳转
            headerView.headerMoreBtnClick = {[weak self]() in
                print("头视图被点击了")
            }
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : HM_RecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_RecommendFooterViewID, for: indexPath) as! HM_RecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}

// - 点击顶部分类按钮进入相对应界面
extension HM_RecommendViewController:HM_RecommendHeaderCellDelegate {
    
    func recommendHeaderBannerClick(url: String) {
        
    }
    
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String){
       
    }
}
// - 点击猜你喜欢按钮进入相对应界面
extension HM_RecommendViewController : HM_RecommendGuessLikeCellDelegate {
    func recommendGuessLikeCellItemClick(model:HM_RecommendListModel) {
        
    }
}
// - 点击热门有声书按钮进入相对应界面
extension HM_RecommendViewController : HM_RecommendHotAudioBookCellDelegate {
    func recommendHotAudioBookCellCilck(model: HM_RecommendListModel) {
        
    }
}
