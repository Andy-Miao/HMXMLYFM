//
//  SYC_Tools.swift
//  SYCGlasses
//
//  Created by humiao on 2018/3/6.
//  Copyright © 2018年 humiao. All rights reserved.
//

import UIKit

class SYC_Tools: NSObject {

    static func colorWithHex(hexValue:NSInteger, alpha:CGFloat)-> UIColor {
        return UIColor(red:(CGFloat((hexValue & 0xFF0000)>>16)), green: (CGFloat((hexValue & 0x00FF00)>>16)), blue: (CGFloat((hexValue & 0x0000FF)>>16)), alpha: alpha)
    }
    /// 字符串转颜色
    static func colorWithHexString(hexValue:String, alpha:CGFloat) -> UIColor {
        let hex = hexValue.hexStringToInt()
        
        return colorWithHex(hexValue: hex, alpha: 1)
    }
    /// 颜色值
    static func Color(color:String) -> UIColor {
        return colorWithHexString(hexValue: color, alpha: 1)
    }
    /// RGB颜色值
    static func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    /// 颜色转图片
    class func imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
