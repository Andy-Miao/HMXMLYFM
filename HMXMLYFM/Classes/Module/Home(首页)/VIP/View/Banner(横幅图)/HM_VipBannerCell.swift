//
//  HM_VipBannerCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/21.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import FSPagerView

protocol HM_VipBannerCellDelegate:NSObjectProtocol {
    func vipBannerCellClick(url:String)
}

class HM_VipBannerCell: UITableViewCell {

    weak var delegate: HM_VipBannerCellDelegate?
    
    var vipBanner: [HM_FocusImagesData]?
    
    let HM_VipBannerCellID = "HM_VipBannerCell"
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3 // 隔多久滑动一次
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: HM_VipBannerCellID)
        return pagerView
    }()
    
    var vipBannerList: [HM_FocusImagesData]? {
        didSet {
            guard let model = vipBannerList else {
                return
            }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        self.pagerView.itemSize = CGSize(width: SCREEN_WIDTH - 60, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HM_VipBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return vipBanner?.count ?? 0
    }
    
   
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell: FSPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: HM_VipBannerCellID, at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = self.vipBanner?[index].link ?? ""
        delegate?.vipBannerCellClick(url: url)
    }
}
