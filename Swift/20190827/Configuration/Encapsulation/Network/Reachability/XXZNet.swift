//
//  XXZNet.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/8/1.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

public let isNetwork = XXZNet.isNetwork()
public let networkStatus = XXZNet.returnNetworkStatus()

private class XXZNet: NSObject {
    private override init() {}
    
    //MARK: ------ Zachary - net ------
    static func returnNetworkStatus() -> Int { //网络类型
        let reach = Reachability.init(hostname: "www.baidu.com")
        let status = reach?.currentReachabilityStatus
        
        var networkStatus = -1
        
        if status == .reachableViaWiFi {
            networkStatus = 1
        }
        else if status == .reachableViaWWAN {
            networkStatus = 2
        }
        else if status == .notReachable {
            networkStatus = 0
        }
        
        return networkStatus
    }
    
    static func isNetwork() -> Bool { //有无网络
        let reach = Reachability.init(hostname: "www.baidu.com")
        let status = reach?.currentReachabilityStatus
        
        var isNetwork = true
        if status == .notReachable {
            isNetwork = false
        }
        
        return isNetwork
    }
}
