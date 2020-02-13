//
//  XXZFuncMethod.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 判断哪个屏幕的设备 ------
private func isWhichDevice (size: CGSize) -> Bool { //比较宽高是否一致
    let flag = __CGSizeEqualToSize(size, SCREEN_SIZE)
    return flag
}

// 4/4s                      320.0, 480.0
// 5/5s/SE                320.0, 568.0
// 6/6s/7/8                375.0, 667.0
// 6/6s/7/8 plus        414.0, 736.0
public let iPhoneFourSeries = isWhichDevice (size: CGSize.init(width: 320.0, height: 480.0))
public let iPhoneFiveSeries = isWhichDevice (size: CGSize.init(width: 320.0, height: 568.0))
public let iPhoneSixSeries = isWhichDevice (size: CGSize.init(width: 375.0, height: 667.0))
public let iPhonePlus = isWhichDevice (size: CGSize.init(width: 414.0, height: 736.0))

//MARK: ------ Zachary - 定义新增方法 ------

