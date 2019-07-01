//
//  HM_PlayDetailLikeController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/7/1.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView
import SwiftyJSON
import HandyJSON

class HM_PlayDetailLikeController: HM_BasisViewController, LTTableViewProtocal {
    private var albumResults:[HM_ClassifyVerticalModel]?
    private let HM_PlayDetailLikeCellID = "HM_PlayDetailLikeCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), self, self, nil)
        tableView.register(HM_PlayDetailLikeCell.self, forCellReuseIdentifier: HM_PlayDetailLikeCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
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
        // 刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        setupLoadData()
    }
    func setupLoadData(){
        HM_PlayDetailAPIProvider.request(.playDetailLikeList(albumId:12825974)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_ClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.albumResults = mappedObject as? [HM_ClassifyVerticalModel]
                    self.tableView.uHead.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension HM_PlayDetailLikeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HM_PlayDetailLikeCell = tableView.dequeueReusableCell(withIdentifier: HM_PlayDetailLikeCellID, for: indexPath) as! HM_PlayDetailLikeCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.classifyVerticalModel = self.albumResults?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.albumResults?[indexPath.row].albumId ?? 0
        let vc = HM_PlayDetailController(albumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

