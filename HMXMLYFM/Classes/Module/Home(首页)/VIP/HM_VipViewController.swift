//
//  HM_VipViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

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
    
    private let HM_HomeVIPCellID           = "HM_HomeVIPCell"
    private let HM_HomeVipHeaderViewID     = "HM_HomeVipHeaderView"
    private let HM_HomeVipFooterViewID     = "HM_HomeVipFooterView"
    private let HM_HomeVipBannerCellID     = "HM_HomeVipBannerCell"
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
        
        
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HM_VipViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        if cell == nil  {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "id")
        }
        return cell;
    }
    
    
}
