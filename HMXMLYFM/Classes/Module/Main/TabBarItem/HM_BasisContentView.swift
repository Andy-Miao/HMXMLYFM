//
//  HM_BasisContentView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class HM_BasisContentView: ESTabBarItemContentView {

    override init(frame : CGRect) {
        super.init(frame: frame)
        textColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = SYC_Tools.RGBColor(r: 254, g: 73, b: 42)
        
        iconColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = SYC_Tools.RGBColor(r: 254, g: 73, b: 42)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
