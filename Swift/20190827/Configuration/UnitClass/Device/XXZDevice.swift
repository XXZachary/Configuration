//
//  XXZDevice.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/8/1.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 设备信息 ------
public let deviceName = UIDevice.current.name //设备名称
public let deviceSystemName = UIDevice.current.systemName //设备系统名称
public let deviceSystemVersion = UIDevice.current.systemVersion //设备系统版本

public let deviceModel = UIDevice.current.model //设备类别
public let deviceLocalizedModel = UIDevice.current.localizedModel //设备本地类别

public let deviceUUID = (UIDevice.current.identifierForVendor?.uuidString)! //设备 uuid
public let deviceOrientation = UIDevice.current.orientation //设备方向

public let deviceBatteryLevel = UIDevice.current.batteryLevel //设备电池级别
public let deviceBatteryState = UIDevice.current.batteryState //设备电池状态

//MARK: ------ Zachary - 其他 ------
