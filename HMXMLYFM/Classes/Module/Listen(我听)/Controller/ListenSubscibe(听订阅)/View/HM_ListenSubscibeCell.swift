//
//  HM_ListenSubscibeCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_ListenSubscibeCell: UITableViewCell {

  // 背景大图
    private lazy var picView : UIImageView = {
        let imageV = UIImageView()
        imageV.layer.masksToBounds = true
        imageV.layer.cornerRadius = 3
        return imageV
    }()
    
    // 标题
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    // 副标题
    private lazy var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 时间
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // 播放按钮
    private lazy var setBtn : UIButton = {
        let btn = UIButton(type:.custom)
        btn.setTitle("...", for:.normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(70)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(picView)
            make.left.equalTo(picView.snp.right).offset(10)
            make.height.equalTo(20)
            make.right.equalToSuperview()
        }
        
        addSubview(subLabel)
        subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.height.right.equalTo(titleLabel)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(titleLabel)
            make.bottom.equalTo(picView)
        }
        
        addSubview(setBtn)
        setBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    // 赋值
    var albumResults: HM_AlbumResultsModel? {
        didSet {
            guard let model = albumResults else {
                return
            }
            
            self.picView.kf.setImage(with: URL(string: model.albumCover!))
            self.titleLabel.text = model.albumTitle
            self.subLabel.text = model.trackTitle
            self.timeLabel.text = updateTimeToCurrennTime(timeStamp: Double(model.lastUpdateAt))
        }
    }
     // - 根据后台时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        // 获取当前时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta: TimeInterval = TimeInterval(timeStamp / 1000)
         // 时间差
        let reduceTime = currentTime - timeSta
        // 时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        // 时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
         // 不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
}
