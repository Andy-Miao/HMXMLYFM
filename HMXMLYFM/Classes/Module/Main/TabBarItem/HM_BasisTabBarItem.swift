//
//  HM_BasisTabBarItem.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/15.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class HM_BasisTabBarItem: HM_BounceContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HM_tabBarItem : ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = SYC_Tools.RGBColor(r:250, g: 48, b: 32)
        self.imageView.layer.borderWidth = 2.0
        self.imageView.layer.borderColor = UIColor(white: 235/255.0, alpha: 1).cgColor
        self.imageView.layer.cornerRadius = 25
        self.insets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        self.imageView.transform = CGAffineTransform.identity
        self.superview?.bringSubview(toFront: self)
        
        textColor = .white
        highlightTextColor = .white
        
        iconColor = .white
        highlightIconColor = .white
        
        backdropColor = .clear
        highlightBackdropColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        
        return sqrt(pow(imageView.bounds.size.width/2.0 - p.x, 2) + pow(imageView.bounds.size.height/2.0-p.y, 2)) < imageView.bounds.size.width/2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint(x: self.bounds.size.width/2.0, y: self.bounds.size.height/2.0)
    }
    
}
