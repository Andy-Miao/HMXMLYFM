//
//  HM_GuessYouLikeMoreController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HM_GuessYouLikeMoreController: HM_BasisViewController {

    var guessYouLikeList: [HM_GuessYouLikeModel]?
    
    let HM_HotAudioBookCellID = "HM_HotAudioBookCell"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HM_HotAudioBookCell.self, forCellWithReuseIdentifier: HM_HotAudioBookCellID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "猜你喜欢"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        // 首页推荐接口请求
        HM_RecommendProvider.request(.guessYouLikeMoreList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let guessYouLikeModel = JSONDeserializer<HM_GuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.guessYouLikeList = guessYouLikeModel as? [HM_GuessYouLikeModel]
                    self.collectionView.reloadData()
                }
            }
        }
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

extension HM_GuessYouLikeMoreController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guessYouLikeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_HotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HM_HotAudioBookCellID, for: indexPath) as! HM_HotAudioBookCell
        cell.guessYouLikeModel = self.guessYouLikeList?[indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:SCREEN_WIDTH - 30,height:120)
    }
}

