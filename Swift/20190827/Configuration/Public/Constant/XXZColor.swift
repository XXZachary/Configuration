//
//  XXZColor.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 定义常用颜色 ------
public let redColor = UIColor.red
public let orangeColor = UIColor.orange
public let yellowColor = UIColor.yellow
public let greenColor = UIColor.green
public let cyanColor = UIColor.cyan
public let blueColor = UIColor.blue
public let purpleColor = UIColor.purple

public let grayColor = UIColor.gray
public let lightGrayColor = UIColor.lightGray
public let darkGrayColor = UIColor.darkGray

public let magentaColor = UIColor.magenta //adj, n 品红, 洋红
public let brownColor = UIColor.brown

public let whiteColor = UIColor.white
public let blackColor = UIColor.black

public let clearColor = UIColor.clear

//MARK: ------ Zachary - 特殊颜色 ------
public func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
    let color = UIColor.init(red: (red)/255.0, green: (green)/255.0, blue: (blue)/255.0, alpha: alpha)
    return color
}

///16进制颜色值转换成UIColor
public func color(_ color: String) -> UIColor {
    // 存储转换后的数值
    var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
    // 计算前缀数量
    var prefixCount = 0
    
    if color.hasPrefix("0x") || color.hasPrefix("0X") {
        prefixCount = 2 // 前缀有两位
    }
    if color.hasPrefix("#") {
        prefixCount = 1 // 前缀有一位
    }
    
    //分别转换进行转换
    Scanner(string: color[(0+prefixCount)..<(2+prefixCount)]).scanHexInt32(&red)
    Scanner(string: color[(2+prefixCount)..<(4+prefixCount)]).scanHexInt32(&green)
    Scanner(string: color[(4+prefixCount)..<(6+prefixCount)]).scanHexInt32(&blue)
    
    return rgb(CGFloat(red), CGFloat(green), CGFloat(blue))
}

// string[int..<int]截取字符串
private extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
}

///混和颜色: ratio在0~1之间, 默认0.5
//func mixColor(_ color1:UIColor, _ color2:UIColor, _ ratio: CGFloat=0.5) -> UIColor {
//    var tmp = ratio
//    if ratio>1 || ratio<0 {
//        tmp = 0.5
//    }
//
//    let components2:[CGFloat] = color2.cgColor.components!
//    let components1:[CGFloat] = color1.cgColor.components!
//
//    let r:CGFloat = components1[0]*tmp+components2[0]*(1-tmp)
//    let g:CGFloat = components1[1]*tmp+components2[1]*(1-tmp)
//    let b:CGFloat = components1[2]*tmp+components2[2]*(1-tmp)
//
//    return rgb(r, g, b)
//}



//MARK: ------ Zachary - 自定义特定颜色 ------
public let LINE_COLOR = color("#f5f5f5")
public let DARK_COLOR = color("#333333")
public let LIGHT_COLOR = color("#999999")

public let BACK_COLOR = color("#FFDA47")


