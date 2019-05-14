//
//  HM_BounceContentView.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_BounceContentView: HM_BasisContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        bounceAnimation()
        completion?()
    }
    func bounceAnimation() {
        // 动画
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95,1.02, 1.0]
        impliesAnimation.duration = 2.0 //持续时间
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }

}
