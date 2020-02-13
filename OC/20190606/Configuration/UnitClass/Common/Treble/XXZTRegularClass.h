//
//  XXZTRegularClass.h
//  ConfigurationDemo
//
//  Created by Jiayu_Zachary on 16/9/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XXZTRegularClass : NSObject

#pragma mark - 三个正则
/**
 *  由中文 | 字母 | 数字组成
 *
 *  @param txt 由中文 | 字母 | 数字组成的字符串
 *
 *  @return YES 匹配, NO 不匹配
 */
+ (BOOL)isChineseOrAlphabetOrDigital:(NSString *)txt;

@end
NS_ASSUME_NONNULL_END
