//
//  HM_WebViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/27.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import WebKit

class HM_WebViewController: HM_BasisViewController {
    private var url:String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }
}
