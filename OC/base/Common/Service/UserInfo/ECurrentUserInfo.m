//
//  ECurrentUserInfo.m
//  Easy2Car
//
//  Created by Zachary on 2018/9/7.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import "ECurrentUserInfo.h"

#define XZCurrentUserInfo_kcmUserId @"current_user_cmUserid"
#define XZCurrentUserInfo_kcmToken @"current_user_cmToken"
#define XZCurrentUserInfo_kcmTelephone @"current_user_cmTelephone"

@implementation ECurrentUserInfo

+ (ECurrentUserInfo *)sharedInstance {
    static ECurrentUserInfo *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
        [instance loadUserInfo];
    });
    return instance;
}

//是否是已登录状态
- (BOOL)isLogined {
    return (self.cmUserId !=nil );
}

//加载当前用户信息
- (void)loadUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults != nil)  {
        self.cmUserId = [defaults objectForKey:XZCurrentUserInfo_kcmUserId];
        self.cmToken = [defaults objectForKey:XZCurrentUserInfo_kcmToken];
        self.cmTelephone = [defaults objectForKey:XZCurrentUserInfo_kcmTelephone];
    }
}

//保存当前用户信息
- (void)saveUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.cmUserId) {
        [defaults setObject:self.cmUserId forKey:XZCurrentUserInfo_kcmUserId];
    }
    if (self.cmToken) {
        [defaults setObject:self.cmToken forKey:XZCurrentUserInfo_kcmToken];
    }
    if (self.cmTelephone) {
        [defaults setObject:self.cmTelephone forKey:XZCurrentUserInfo_kcmTelephone];
    }
    
    [defaults synchronize];
}

- (BOOL)clearUserInfo {
    self.cmUserId = nil;
    self.cmToken = nil;
//    self.cmTelephone = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:XZCurrentUserInfo_kcmUserId];
    [defaults removeObjectForKey:XZCurrentUserInfo_kcmToken];
//    [defaults removeObjectForKey:XZCurrentUserInfo_kcmTelephone];
    
    return [defaults synchronize];
}

- (void)logout {
    [self clearUserInfo];
}

@end
