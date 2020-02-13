//
//  XXZNotification.m
//  DaiHotel
//
//  Created by Zachary on 2017/4/26.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "XXZNotification.h"

@implementation XXZNotification

//去掉 使用到的过期api 的警告
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

/*
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wdeprecated-declarations"
 // 这部分使用到的过期api
 #pragma clang diagnostic pop
 */

#pragma mark - local notification
//注册本地通知服务
+ (void)registerLocalNotificationWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    // 设置应用程序的图标右上角的数字
    [application setApplicationIconBadgeNumber:0];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    // 界面的跳转(针对应用程序被杀死的状态下的跳转)
    // 杀死状态下的，界面跳转并不会执行下面的方法
    //- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification，
    // 所以我们在写本地通知的时候，要在这个与下面方法中写，但要判断，是通过哪种类型通知来打开的
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 跳转代码
        XXZLog(@"UIApplicationLaunchOptionsLocalNotificationKey");
    }
}

// 创建一条本地通知
+ (void)createLocalNotification:(NSInteger)alertTime alertBody:(NSString *)alertBody userDict:(NSDictionary *)userDict {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 重复的间隔
//    notification.repeatInterval = kCFCalendarUnitSecond;
    // 提示
//    notification.alertTitle = @"提示";
    // 通知内容
    notification.alertBody = alertBody;
    //app 显示
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    notification.userInfo = userDict; //@{@"type" : fireDate};
    
    // iOS8后, 需要添加这个注册, 才能得到授权
    //不设置重复间隔, 通知过后, 自动移除该通知
    // 通知重复提示的单位, 可以是天、周、月
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        notification.repeatInterval = NSCalendarUnitDay; //NSCalendarUnitDay
    }
    else {
        notification.repeatInterval = 0; //NSDayCalendarUnit
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithInfo:(NSDictionary *)info {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            //如果存在, 移除
            if ([userInfo isEqualToDictionary:info]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

#pragma mark - remote notification
//注册远程通知服务
+ (void)registerRemoteNotificationWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) { //iOS8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else { // iOS7
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeNewsstandContentAvailability | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    }
    
    // 根据远程通知通过UIApplicationLaunchOptionsRemoteNotificationKey打开的情况来进行
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        // 跳转
        // 添加一个红色的View
    }
}

@end
