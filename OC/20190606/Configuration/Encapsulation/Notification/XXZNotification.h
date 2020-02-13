//
//  XXZNotification.h
//  DaiHotel
//
//  Created by Zachary on 2017/4/26.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZNotification : NSObject

#pragma mark - local notification
/**
 *注册本地通知服务
 */
+ (void)registerLocalNotificationWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions;

/**
 *创建一条本地通知
 */
+ (void)createLocalNotification:(NSInteger)alertTime alertBody:(NSString *)alertBody userDict:(NSDictionary *)userDict;

/**
 *取消某个本地推送通知
 */
+ (void)cancelLocalNotificationWithInfo:(NSDictionary *)info;

#pragma mark - remote notification
//注册远程通知服务
+ (void)registerRemoteNotificationWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions;

@end
