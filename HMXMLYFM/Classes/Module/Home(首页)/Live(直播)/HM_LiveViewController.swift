//
//  HM_LiveViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

let HM_HomeLiveSectionGrid     = 0   // 分类section
let HM_HomeLiveSectionBanner   = 1   // 滚动图片section
let HM_HomeLiveSectionRank     = 2   // 排行榜section
let HM_HomeLiveSectionLive     = 3   // 直播section

class HM_LiveViewController: HM_BasisViewController {
    var lives:[HM_LivesModel]?
    
    private let HM_HomeLiveHeaderViewID = "HM_HomeLiveHeaderView"
    private let HM_HomeLiveGridCellID   = "HM_HomeLiveGridCell"
    private let HM_HomeLiveBannerCellID = "HM_HomeLiveBannerCell"
    private let HM_HomeLiveRankCellID   = "HM_HomeLiveRankCell"
    private let HM_RecommendLiveCellID = "HM_RecommendLiveCell"
    
    
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
