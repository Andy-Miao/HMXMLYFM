//
//  HM_PlayViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_PlayViewController: HM_BasisViewController {
    // 外部传值请求接口
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    private let HM_PlayHeaderViewID      = "HM_PlayHeaderView"
    private let HM_PlayFooterViewID      = "HM_PlayFooterView"
    
    private let HM_PlayCellID            = "HM_PlayCell"
    private let HM_PlayCommentCellID     = "HM_PlayCommentCell"
    private let HM_PlayAnchorCellID      = "HM_PlayAnchorCell"
    private let HM_PlayCircleCellID      = "HM_PlayCircleCell"
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
        collection.register(HM_PlayHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_PlayHeaderViewID)
        collection.register(HM_PlayFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_PlayFooterViewID)
        // - 注册不同分区cell
        collection.register(HM_PlayCell.self, forCellWithReuseIdentifier: HM_PlayCellID)
        collection.register(HM_PlayCommentCell.self, forCellWithReuseIdentifier: HM_PlayCommentCellID)
        collection.register(HM_PlayAnchorCell.self, forCellWithReuseIdentifier: HM_PlayAnchorCellID)
        collection.register(HM_PlayCircleCell.self, forCellWithReuseIdentifier: HM_PlayCircleCellID)
        
        return collection
    }()
    
    lazy var viewModel: HM_PlayViewModel = {
        return HM_PlayViewModel(albumId:self.albumId,trackUid:self.trackUid, uid:self.uid)
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton1:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_more_black_30x30_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton2:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_share_black_30x30_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 设置导航栏颜色
        navBarBarTintColor = UIColor.white
        navBarBackgroundAlpha = 0
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        loadData()
        
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
        let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    
    func loadData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    // 控制向上滚动显示导航栏标题和左右按钮
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > 0)
        {
            navBarBackgroundAlpha = 1
        }else{
            navBarBackgroundAlpha = 0
        }
    }
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick1() {
        
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }
}
extension HM_PlayViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:HM_PlayCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_PlayCellID, for: indexPath) as! HM_PlayCell
            cell.playTrackInfo = viewModel.playTrackInfo
            return cell
        }else if indexPath.section == 1{
            let cell:HM_PlayAnchorCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_PlayAnchorCellID, for: indexPath) as! HM_PlayAnchorCell
            cell.userInfo = viewModel.userInfo
            return cell
        }else if indexPath.section == 2{
            let cell:HM_PlayCircleCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_PlayCircleCellID, for: indexPath) as! HM_PlayCircleCell
            cell.communityInfo = viewModel.communityInfo
            return cell
        }else{
            let cell:HM_PlayCommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_PlayCommentCellID, for: indexPath) as! HM_PlayCommentCell
            cell.playCommentInfo = viewModel.playCommentInfo?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = YYNavigationController.init(rootViewController: FMPlayDetailController())
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        self.dismiss(animated: true, completion: nil)
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
            let headerView : HM_PlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HM_PlayHeaderViewID, for: indexPath) as! HM_PlayHeaderView
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : HM_PlayFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HM_PlayFooterViewID, for: indexPath) as! HM_PlayFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
