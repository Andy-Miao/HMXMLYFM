//
//  HM_ListenRecommendController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_ListenRecommendController: HM_BasisViewController , LTTableViewProtocal {

     private let HM_ListenRecommendCellID = "HM_ListenRecommendCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBAR_HEIGHT - NAVBAR_HEIGHT), self, self, nil)
        tableView.register(HM_ListenRecommendCell.self, forCellReuseIdentifier: HM_ListenRecommendCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        // tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    lazy var viewModel: HM_ListenRecommendViewModel = {
        return HM_ListenRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // 加载数据
        loadData()
    }
    
    func loadData () {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HM_ListenRecommendController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_ListenRecommendCell = tableView.dequeueReusableCell(withIdentifier: HM_ListenRecommendCellID, for: indexPath) as! HM_ListenRecommendCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.albums = viewModel.albums?[indexPath.row]
        return cell
    }
}
