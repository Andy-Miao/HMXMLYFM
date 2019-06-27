//
//  HM_FindDudController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class HM_FindDudController: HM_BasisViewController , LTTableViewProtocal {
    private var findDudList: [HM_FindDudModel]?
    private let HM_FindDudCellID = "FindDudCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT), self, self, nil)
        tableView.register(HM_FindDudCell.self, forCellReuseIdentifier: HM_FindDudCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
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
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        // 1. 获取json文件路径
        let path = Bundle.main.path(forResource: "FindDud", ofType: "json")
        // 2. 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3. 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<HM_FMFindDudModel>.deserializeFrom(json: json.description) {
            self.findDudList = mappedObject.data
            self.tableView.reloadData()
        }
    }
}

extension HM_FindDudController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.findDudList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_FindDudCell = tableView.dequeueReusableCell(withIdentifier: HM_FindDudCellID, for: indexPath) as! HM_FindDudCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.findDudModel = self.findDudList?[indexPath.row]
        return cell
    }
}
