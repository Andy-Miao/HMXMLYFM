//
//  HM_Header.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/15.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftMessages

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let BTN_COLOR = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let DOWN_COLOR = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// 刘海
let IPHONE_X = SCREEN_HEIGHT == 812 ? true : false
// 导航
let NAVBAR_HEIGHT : CGFloat = IPHONE_X ? 88 : 64
// 底部
let TABBAR_HEIGHT : CGFloat = IPHONE_X ? 49 + 34 : 49
