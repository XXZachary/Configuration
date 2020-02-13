//
//  XXZUserIdInfo.h
//  Easy2Car
//
//  Created by Zachary on 2018/11/22.
//  Copyright © 2018 www.xxzachary.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXZUserIdInfo : NSObject

/**
 * 获取性别: 1 男, 2 女
 */
+ (NSString *)getIdentityCardSex:(NSString *)cardNum;

/**
 * 获取出生年月日
 */
+ (NSMutableDictionary *)getIdentityCardBirthday:(NSString *)cardNum;

/**
 * 根据身份证获取年龄
 */
+ (NSString *)getIdentityCardAge:(NSString *)cardNum;

@end

NS_ASSUME_NONNULL_END
