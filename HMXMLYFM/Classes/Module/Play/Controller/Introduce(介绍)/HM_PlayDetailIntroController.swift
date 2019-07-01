//
//  HM_PlayDetailIntroController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/7/1.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_PlayDetailIntroController: HM_BasisViewController, LTTableViewProtocal {

    private var playDetailAlbum:HM_PlayDetailAlbumModel?
    private var playDetailUser:HM_PlayDetailUserModel?
    
    private let HM_PlayContentIntroCellID = "HM_PlayContentIntroCell"
    private let HM_PlayAnchorIntroCellID  = "HM_PlayAnchorIntroCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), self, self, nil)
        tableView.register(HM_PlayContentIntroCell.self, forCellReuseIdentifier: HM_PlayContentIntroCellID)
        tableView.register(HM_PlayAnchorIntroCell.self, forCellReuseIdentifier: HM_PlayAnchorIntroCellID)
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
        
        // Do any additional setup after loading the view.
    }
    

    // 内容简介model
    var playDetailAlbumModel:HM_PlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            self.playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.none)
            }
        }
    }
    // 主播简介model
    var playDetailUserModel:HM_PlayDetailUserModel? {
        didSet{
            guard let model = playDetailUserModel else {return}
            self.playDetailUser = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.none)
            }        }
        
    }

}


extension HM_PlayDetailIntroController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:HM_PlayContentIntroCell = tableView.dequeueReusableCell(withIdentifier: HM_PlayContentIntroCellID, for: indexPath) as! HM_PlayContentIntroCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.playDetailAlbumModel = self.playDetailAlbum
            return cell
        }else {
            let cell:HM_PlayAnchorIntroCell = tableView.dequeueReusableCell(withIdentifier: HM_PlayAnchorIntroCellID, for: indexPath) as! HM_PlayAnchorIntroCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.playDetailUserModel = self.playDetailUser
            return cell
        }
    }
}



