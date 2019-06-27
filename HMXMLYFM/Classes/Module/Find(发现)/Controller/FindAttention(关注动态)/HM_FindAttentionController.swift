//
//  HM_FindAttention.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_FindAttentionController: HM_BasisViewController, LTTableViewProtocal {

    private let HM_FindAttentionCellID = "HM_FindAttentionCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT), self, self, nil)
        tableView.register(HM_FindAttentionCell.self, forCellReuseIdentifier: HM_FindAttentionCellID)
        return tableView
    }()
    
    // 懒加载
    lazy var viewModel: HM_FindAttentionViewModel = {
        return HM_FindAttentionViewModel()
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
    
    func loadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }

}

extension HM_FindAttentionController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HM_FindAttentionCell = tableView.dequeueReusableCell(withIdentifier: HM_FindAttentionCellID, for: indexPath) as! HM_FindAttentionCell
        cell.selectionStyle = .none
        cell.eventInfosModel = viewModel.eventInfos?[indexPath.row]
        return cell
    }
    
}
