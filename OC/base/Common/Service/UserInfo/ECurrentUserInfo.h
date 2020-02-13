//
//  ECurrentUserInfo.h
//  Easy2Car
//
//  Created by Zachary on 2018/9/7.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECurrentUserInfo : NSObject

@property (nonatomic, copy) NSString *cmUserId;
@property (nonatomic, copy) NSString *cmToken;
@property (nonatomic, copy) NSString *cmTelephone;

+ (ECurrentUserInfo *)sharedInstance;

//加载当前用户信息
- (void)loadUserInfo;
//保存当前用户信息
- (void)saveUserInfo;
//清除当前用户信息
- (BOOL)clearUserInfo;

//是否是已登录状态
- (BOOL)isLogined;

- (void)logout;

@end
