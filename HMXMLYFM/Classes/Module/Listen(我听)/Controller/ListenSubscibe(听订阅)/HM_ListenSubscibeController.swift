//
//  HM_ListenSubscibeController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_ListenSubscibeController: HM_BasisViewController, LTTableViewProtocal {

    lazy var footerView: HM_ListenFooterView = {
        let footV = HM_ListenFooterView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
         footV.listenFooterViewTitle = "➕添加订阅"
        return footV
    }()
    
    private let HM_ListenSubscibeCellID = "HM_ListenSubscibeCell"
    
    lazy var viewModel: HM_ListenSubscibeViewModel = {
        return HM_ListenSubscibeViewModel()
    }()
    
    lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), self, self, nil)
        tableView.register(HM_ListenSubscibeCell.self, forCellReuseIdentifier: HM_ListenSubscibeCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        //  tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
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
        
        laodData()
    }
    
    func laodData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HM_ListenSubscibeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_ListenSubscibeCell = tableView.dequeueReusableCell(withIdentifier: HM_ListenSubscibeCellID, for: indexPath) as! HM_ListenSubscibeCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.albumResults = viewModel.albumResults?[indexPath.row]
        return cell
    }
}
