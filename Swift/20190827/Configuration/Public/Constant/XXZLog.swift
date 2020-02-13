//
//  XXZLog.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2016/9/5.
//  Copyright © 2016年 Zachary. All rights reserved.
//

import UIKit

//MARK: ----- Zachary - XZLog -----

#if DEBUG
public func XXZLog<agr> (_ message:agr, file: String = #file, function: String = #function, line: Int = #line) { //输出日志
    print("= >> \(XXZDate.dateWithFormat(Date.init()))  [\((file as NSString).lastPathComponent)]: [\(line): \(function)]\n= >> \(message)\n------------------------------------------------------------------------------------------")
}

public func XZLog<agr> (_ message:agr, file: String = #file, function: String = #function, line: Int = #line) { //输出日志
    print("= >> \(XXZDate.dateWithFormat(Date.init()))  [\((file as NSString).lastPathComponent)]: [\(line): \(function)]\n= >> \(message)\n------------------------------------------------------------------------------------------")
}

#else

public func XXZLog<agr> (_ message:agr) {
    
}

public func XZLog<agr> (_ message:agr) {
    
}

#endif

//MARK: ----- Zachary - other -----
