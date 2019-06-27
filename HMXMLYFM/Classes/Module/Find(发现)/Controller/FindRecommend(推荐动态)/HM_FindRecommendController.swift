//
//  HM_FindRecommendController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_FindRecommendController: HM_BasisViewController, LTTableViewProtocal {

    // view
    private let HM_FindRecommendCellID = "HM_FindRecommendCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT), self, self, nil)
        tableView.register(HM_FindRecommendCell.self, forCellReuseIdentifier: HM_FindRecommendCellID)
        return tableView
    }()
    
    lazy var viewModel: HM_FindRecommendViewModel = {
        return HM_FindRecommendViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        loadData()
    }
    
    // viewModel
    
    func loadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }

}

// delegate
extension HM_FindRecommendController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_FindRecommendCell = tableView.dequeueReusableCell(withIdentifier: HM_FindRecommendCellID, for: indexPath) as! HM_FindRecommendCell
        cell.streamModel = viewModel.streamList?[indexPath.row]
        return cell
    }
}

