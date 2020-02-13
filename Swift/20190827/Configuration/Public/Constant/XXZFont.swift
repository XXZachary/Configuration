//
//  XXZFont.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 常用字体字号 ------
public func FONT_S(_ size:CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size)
    return font
}

public func FONT_B(_ size:CGFloat) -> UIFont {
    let font = UIFont.boldSystemFont(ofSize: size)
    return font
}

//MARK: ------ Zachary - 自定义字体字号 ------
public func FONT_M(_ size:CGFloat, _ name:String="PingFangSC-Medium") -> UIFont {
    let font = UIFont.init(name: name, size: size)
    return font!
}
