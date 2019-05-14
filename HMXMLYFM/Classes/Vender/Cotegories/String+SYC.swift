//
//  String+SYC.swift
//  SYCGlasses
//
//  Created by humiao on 2018/3/6.
//  Copyright © 2018年 humiao. All rights reserved.
//

import UIKit

extension String {
    func hexStringToInt() -> Int {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 //0-9从48开始
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
    }
}
