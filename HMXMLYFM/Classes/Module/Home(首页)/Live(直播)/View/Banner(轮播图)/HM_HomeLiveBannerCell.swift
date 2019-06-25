//
//  HM_HomeLiveBannerCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/24.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftMessages
import FSPagerView

class HM_HomeLiveBannerCell: UICollectionViewCell {
    var liveBanner: [HM_HomeLiveBanerList]?
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "HM_HomeLiveBannerCell")
        return pagerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var bannerList : [HM_HomeLiveBanerList]? {
        didSet {
            guard let model = bannerList else {
                return
            }
            self.liveBanner = model
            self.pagerView.reloadData()
        }
    }
}

extension HM_HomeLiveBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int{
        return self.liveBanner?.count ?? 0
    }
 
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier:"HM_HomeLiveBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.liveBanner?[index].cover)!))
        return cell
    }
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "暂时没有点击功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
}
