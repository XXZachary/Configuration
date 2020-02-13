//
//  XXZNet.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/4/10.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface XXZNet : NSObject

/**
 *  返回网络类型
 *
 *  @return 0 无网络, 1 蜂窝, 2 wifi
 */
+ (NetworkStatus)netType;

@end

//注册监听网络变化
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

#if 0
//监听网络的变化
-(void)reachabilityChanged:(NSNotification*)note {
    Reachability * reach = [note object];
    NSInteger status = reach.currentReachabilityStatus;
    
    if([reach isReachable]){//有网络
        status = 1;
        XXZLog(@"来网了..");
    }else{//无网络
        status = 0;
        XXZLog(@"网走了..");
    }
}
#endif
