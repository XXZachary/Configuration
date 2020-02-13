//
//  XXZFrame.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import UIKit

//MARK: ----- Zachary - 当前屏幕的宽高
public let SCREEN_BOUNDS = (UIScreen.main.bounds)
public let SCREEN_SIZE = (SCREEN_BOUNDS.size)
public let SCREEN_WIDTH = (SCREEN_SIZE.width)
public let SCREEN_HEIGHT = (SCREEN_SIZE.height)

public let RATIO_WIDTH = (SCREEN_WIDTH/320)
public let RATIO_HEIGHT = (SCREEN_HEIGHT/480)

//MARK: ------ Zachary - 安全区 ------
public let IS_iPhone_X_All = (SCREEN_HEIGHT==812.0 || SCREEN_HEIGHT==896.0)

public let Safe_Status_H = (IS_iPhone_X_All ? 44.0 : 20.0) //状态栏
public let SafeArea_Navbar_H = (IS_iPhone_X_All ? 88.0 : 64.0) //导航条+状态栏
public let SafeArea_Tabbar_H = (IS_iPhone_X_All ? 83.0 : 49.0) //工具栏

public let SafeArea_Top_H = (IS_iPhone_X_All ? 24.0 : 00.0) //顶部安全区
public let SafeArea_Bottom_H = (IS_iPhone_X_All ? 34.0 : 0.0) //底部安全区

//MARK: ----- Zachary - other

