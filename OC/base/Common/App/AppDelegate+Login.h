//
//  AppDelegate+Login.h
//  Zachary
//
//  Created by Zachary on 2018/8/31.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Login)

- (void)switchAppLogin; //登录页
- (void)switchAppHome; //登录主页

- (void)switchAppLogout; //退出登录

// 获取当前活动的navigationController
- (UINavigationController *)navigationViewController;

@end
