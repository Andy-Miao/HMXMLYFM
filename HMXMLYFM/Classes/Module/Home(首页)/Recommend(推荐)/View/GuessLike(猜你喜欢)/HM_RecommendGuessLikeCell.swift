//
//  HM_RecommendGuessLikeCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/22.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
// 添加协议
protocol HM_RecommendGuessLikeCellDelegate:NSObjectProtocol {
    func recommendGuessLikeCellItemClick(model:HM_RecommendListModel)
}
class HM_RecommendGuessLikeCell: UICollectionViewCell {
    //MARK: 属性
    weak var delegate : HM_RecommendGuessLikeCellDelegate?
    
    private var recommendList:[HM_RecommendListModel]?
    private var HM_GuessYouLikeCellID = "HM_GuessYouLickCell"
    
    private lazy var changeBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(BTN_COLOR, for: .normal)
        button.backgroundColor = SYC_Tools.RGBColor(r: 254, g: 232, b: 227)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HM_GuessYouLikeCell.self, forCellWithReuseIdentifier: HM_GuessYouLikeCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recommendListData : [HM_RecommendListModel]? {
        didSet {
            guard let model = recommendListData else {
                return
            }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    
    @objc func updataBtnClick(button:UIButton) {
        HM_RecommendProvider.request(.changeGuessYouLikeList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                guard (data != nil) else {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                        let warning = MessageView.viewFromNib(layout: .cardView)
                        warning.configureDropShadow()
                        
                        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                        warning.configureContent(title: "", body: "亲，系统出错啦，等等再试好不啦？", iconText: iconText)
                        warning.button?.isHidden = true
                        var warningConfig = SwiftMessages.defaultConfig
                        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
                        SwiftMessages.show(config: warningConfig, view: warning)
                    })
                    return;
                }
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HM_RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [HM_RecommendListModel]
                    // 刷新数据
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension HM_RecommendGuessLikeCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_GuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_GuessYouLikeCellID, for: indexPath) as! HM_GuessYouLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    //点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0)
    }
     //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 55)/3, height: 180)
    }
}
