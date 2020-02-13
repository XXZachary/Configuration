//
//  XXZNet.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/4/10.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "XXZNet.h"

@implementation XXZNet

//返回网络类型
+ (NetworkStatus)netType {
    //初始化网络
    Reachability *baiduReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [baiduReach startNotifier];
    
    //网络状态
    NetworkStatus status = baiduReach.currentReachabilityStatus;
    //NotReachable: //0 //无网络
    //ReachableViaWiFi: //2 //WIFI
    //ReachableViaWWAN: //1 //蜂窝
    
    return status;
}

@end
