//
//  HM_VipViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftMessages

let HM_HomeVipSectionBanner    = 0   // 滚动图片section
let HM_HomeVipSectionGrid      = 1   // 分类section
let HM_HomeVipSectionHot       = 2   // 热section
let HM_HomeVipSectionEnjoy     = 3   // 尊享section
let HM_HomeVipSectionVip       = 4   // vip section

class HM_VipViewController: HM_BasisViewController {

    // - 上页面传过来请求接口必须的参数
    convenience init(isRecommendPush:Bool = false) {
        self.init()
        self.tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH ,height:SCREEN_HEIGHT)
    }
    
    private let HM_VipCellID           = "HM_VipCell"
    private let HM_VipHeaderViewID     = "HM_VipHeaderView"
    private let HM_VipFooterViewID     = "HM_VipFooterView"
    private let HM_VipBannerCellID     = "HM_VipBannerCell"
    private let HM_HomeVipCategoriesCellID = "HM_HomeVipCategoriesCell"
    private let HM_HomeVipHotCellID        = "HM_HomeVipHotCell"
    private let HM_HomeVipEnjoyCellID      = "HM_HomeVipEnjoyCell"
    
    private var currentTopSectionCount: Int64 = 0
    
    lazy var headView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT - 44 - TABBAR_HEIGHT), style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // 注册头尾视图
        tableView.register(HM_VipHeaderView.self, forHeaderFooterViewReuseIdentifier: HM_VipHeaderViewID)
        tableView.register(HM_VipFooterView.self, forHeaderFooterViewReuseIdentifier: HM_VipFooterViewID)
        // 注册分区cell
        tableView.register(HM_VipCell.self, forCellReuseIdentifier: HM_VipCellID)
        tableView.register(HM_VipBannerCell.self , forCellReuseIdentifier: HM_VipBannerCellID)
        tableView.register(HM_HomeVipCategoriesCell.self , forCellReuseIdentifier: HM_HomeVipCategoriesCellID)
        tableView.register(HM_HomeVipHotCell.self , forCellReuseIdentifier: HM_HomeVipHotCellID)
        tableView.register(HM_HomeVipEnjoyCell.self , forCellReuseIdentifier: HM_HomeVipEnjoyCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return tableView
    }()
    
    lazy var viewModel: HM_VipViewModel = {
        return HM_VipViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        
        self.tableView.uHead.beginRefreshing()
        
        loadData()
        // Do any additional setup after loading the view.
    }
   
     // 加载数据
    func loadData() {
        viewModel.updataBlock = { [unowned self] in
            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
    
        viewModel.refreshDataSource()
    }


}

extension HM_VipViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case HM_HomeVipSectionBanner:
            let cell:HM_VipBannerCell = tableView.dequeueReusableCell(withIdentifier: HM_VipBannerCellID, for: indexPath) as! HM_VipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case HM_HomeVipSectionGrid:
            let cell:HM_HomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: HM_HomeVipCategoriesCellID, for: indexPath) as! HM_HomeVipCategoriesCell
            cell.categorBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
        case HM_HomeVipSectionHot:
            let cell:HM_HomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: HM_HomeVipHotCellID, for: indexPath) as! HM_HomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        case HM_HomeVipSectionEnjoy:
            let cell:HM_HomeVipEnjoyCell = tableView.dequeueReusableCell(withIdentifier: HM_HomeVipEnjoyCellID, for: indexPath) as! HM_HomeVipEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            let cell:HM_VipCell = tableView.dequeueReusableCell(withIdentifier: HM_VipCellID, for: indexPath) as! HM_VipCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:HM_VipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HM_VipHeaderViewID) as! HM_VipHeaderView
        headerView.titStr = viewModel.categoryList?[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = DOWN_COLOR
        return view
    }
}

extension HM_VipViewController:HM_VipBannerCellDelegate {
    
    func vipBannerCellClick(url: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "暂时没有点击功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}

// - 点击顶部分类按钮 delegate
extension HM_VipViewController:HM_HomeVipCategoriesCellDelegate{
    func homeVipCategoriesCellItemClick(id: String, url: String,title:String) {

    }
}

// - 点击热播item delegate
extension HM_VipViewController:HM_HomeVipHotCellDelegate{
    func homeVipHotCellItemClick(model: HM_CategoryContents) {
      
    }
}

// - 点击Vip尊享课item delegate
extension HM_VipViewController:HM_HomeVipEnjoyCellDelegate{
    func homeVipEnjoyCellItemClick(model: HM_CategoryContents) {
       
    }
}
