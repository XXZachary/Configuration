//
//  XXZDRegularClass.h
//  ConfigurationDemo
//
//  Created by Jiayu_Zachary on 16/9/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XXZDRegularClass : NSObject

#pragma mark - 两个正则
/**
 *  由字母 | 数字组成
 */
+ (BOOL)isAlphabetOrDigital:(NSString *)txt;

/**
 *  由中文 | 字母组成
 */
+ (BOOL)isChineseOrAlphabet:(NSString *)txt;

/**
 *  由中文 | 数字组成
 */
+ (BOOL)isChineseOrDigital:(NSString *)txt;

@end
NS_ASSUME_NONNULL_END
