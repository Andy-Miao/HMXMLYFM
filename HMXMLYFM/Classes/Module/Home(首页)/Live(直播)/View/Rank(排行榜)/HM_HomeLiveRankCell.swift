//
//  HM_HomeLiveRankCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_HomeLiveRankCell: UICollectionViewCell {
    private var multidimensionalRankVosList: [HM_MultidimensionalRankVosModel]?
    
    private let HM_LiveRankCellID = "HM_LiveRankCell"
    // - 滚动排行榜
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-30), height: self.frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.contentSize = CGSize(width: (SCREEN_WIDTH - 30), height: self.frame.size.height)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HM_LiveRankCell.self , forCellWithReuseIdentifier: HM_LiveRankCellID)
        return collectionView
    }()
    
    var timer: Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        starTimer()
    }
    
    // 界面赋值并刷新
    var multidimensionalRankVos:[HM_MultidimensionalRankVosModel]? {
        didSet {
            guard let model = multidimensionalRankVos else { return }
            self.multidimensionalRankVosList = model
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension HM_HomeLiveRankCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.multidimensionalRankVosList?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_LiveRankCellID, for: indexPath) as! HM_LiveRankCell
        cell.backgroundColor = UIColor.init(red: 248, green: 245, blue: 246, alpha: 1)
        cell.multidimensionalRankVos = self.multidimensionalRankVosList?[indexPath.row%(self.multidimensionalRankVosList?.count)!]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row % (self.multidimensionalRankVosList?.count)!)
    }
    /// 开启定时器
    func starTimer() {
        let timer = Timer(timeInterval: 3, target: self, selector:#selector(nextPage), userInfo: nil, repeats:true)
         // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(timer, forMode:.commonModes)
        self.timer = timer
    }
    /// 在1秒后,自动跳转到下一页
    @objc func nextPage() {
        // 1.获取collectionView的X轴滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    /// 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        starTimer()
    }
}
