//
//  HM_HomeLiveGridCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

// 协议
protocol HM_HomeLiveGridCellDelegate: NSObjectProtocol {
    func homeLiveGridCellItemClick(channelId:Int, title:String)
}
class HM_HomeLiveGridCell: UICollectionViewCell {
    weak var delegate: HM_HomeLiveGridCellDelegate?
    
    private let HM_LiveHeaderGridCellID = "HM_LiveHeaderGridCell"
    
    let imageArr = [
        "http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
        "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
        "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
        "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
        "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png"
    ]
    
    let titleArr = ["温暖男声","心动女神","唱将达人","情感治愈","直播圈子"]
    
    // - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width:(SCREEN_WIDTH-30)/5, height: 90)
        
        let collevtionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 30, height: 90), collectionViewLayout: layout)
        collevtionView.delegate = self
        collevtionView.dataSource = self
        collevtionView.backgroundColor = .white
        collevtionView.register(HM_LiveHeaderGridCell.self , forCellWithReuseIdentifier: HM_LiveHeaderGridCellID)
        return collevtionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HM_HomeLiveGridCell:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_LiveHeaderGridCellID, for: indexPath) as! HM_LiveHeaderGridCell
        cell.backgroundColor = UIColor.white
        cell.imageUrl = self.imageArr[indexPath.row]
        cell.titleString = self.titleArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeLiveGridCellItemClick(channelId: indexPath.row + 5,title:self.titleArr[indexPath.row])
    }
    
}
