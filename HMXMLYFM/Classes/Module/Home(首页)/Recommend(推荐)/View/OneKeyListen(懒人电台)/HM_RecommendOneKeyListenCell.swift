//
//  HM_RecommendOneKeyListenCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/28.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RecommendOneKeyListenCell: UICollectionViewCell {
    
    
    var oneKeyListenList:[HM_OneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            
        }
    }
}
