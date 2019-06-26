//
//  HM_ListenChannelController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_ListenChannelController: HM_BasisViewController,LTTableViewProtocal {

    // - footerView
    private lazy var footerView:HM_ListenFooterView = {
        let view = HM_ListenFooterView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:100))
        view.listenFooterViewTitle = "➕添加频道"
        view.delegate = self
        return view
    }()
    
    private let HM_ListenChannelCellID = "HM_ListenChannelCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 5, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), self, self, nil)
        tableView.register(HM_ListenChannelCell.self, forCellReuseIdentifier: HM_ListenChannelCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: HM_ListenChannelViewModel = {
        return HM_ListenChannelViewModel()
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
        // 请求数据
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

extension HM_ListenChannelController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_ListenChannelCell = tableView.dequeueReusableCell(withIdentifier: HM_ListenChannelCellID, for: indexPath) as! HM_ListenChannelCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        cell.channelResults = viewModel.channelResults?[indexPath.row]
        return cell
    }
}

// - 底部添加频道按钮点击delegate
extension HM_ListenChannelController :HM_ListenFooterViewDelegate {
    func listenFooterViewClick() {
        let vc = HM_ListenMoreChannelController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
