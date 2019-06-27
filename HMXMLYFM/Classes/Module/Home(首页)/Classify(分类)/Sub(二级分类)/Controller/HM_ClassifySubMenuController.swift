//
//  HM_ClassifySubMenuController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView

class HM_ClassifySubMenuController: HM_BasisViewController {
    private var categoryId: Int = 0
    private var isVipPush:Bool = false
    
    convenience init(categoryId: Int = 0,isVipPush:Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    
    private var Keywords:[HM_ClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    private lazy var keywordIdArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 加载头部分类数据
        loadHeaderCategoryData()
    }
    // 加载头部分类数据
    func loadHeaderCategoryData(){
        //分类二级界面顶部分类接口请求
        HM_ClassifySubMenuProvider.request(HM_ClassifySubMenuAPI.headerCategoryList(categoryId: self.categoryId)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HM_ClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    self.Keywords = mappedObject as? [HM_ClassifySubMenuKeywords]
                    for keyword in self.Keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush{
                        self.nameArray.insert("推荐", at: 0)
                    }
                    self.setupHeaderView()
                }
            }
        }
    }
    
    func setupHeaderView(){
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = BTN_COLOR
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = DOWN_COLOR
        
        // 创建每一页对应的controller
        var viewControllers = [UIViewController]()
        for keyword in self.Keywords! {
            let controller = HM_ClassifySubContentController(keywordId:keyword.keywordId, categoryId:keyword.categoryId)
            viewControllers.append(controller)
        }
        if !self.isVipPush{
            // 这里需要插入推荐的控制器，因为接口数据中并不含有推荐
            let categoryId = self.Keywords?.last?.categoryId
            viewControllers.insert(HM_ClassifySubRecommendController(categoryId:categoryId!), at: 0)
        }
        
        for vc in viewControllers{
            self.addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
}
