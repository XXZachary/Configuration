//
//  XXZInterface.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import Foundation

//MARK: ------ Zachary - 定义主域名 ------
public let formalPath = "https://www.carwish.cn/index.php/api" //正式服
public let testPath = "https://test.carwish.cn/index.php/api" //测试服

public var HttpUrlHost = ""

func setHttpUrlHost(_ url:String=formalPath) {
    HttpUrlHost = url
}

//MARK: ------ Zachary - 定义接口 ------
