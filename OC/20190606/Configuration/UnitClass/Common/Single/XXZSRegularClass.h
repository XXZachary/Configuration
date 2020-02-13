//
//  XXZSRegularClass.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzd.future. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XXZSRegularClass : NSObject

#pragma mark - 单一正则
/**
 *  通用邮箱正则验证
 *
 *  @param email 通用邮箱正则验证
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  全部由数字组成的字符串
 *
 *  @param txt 全部由数字组成的字符串
 *  @param is YES 是, NO 不是
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isAllDigital:(NSString *)txt is:(BOOL)is;

/**
 *  全部由字母组成的字符串
 *
 *  @param txt 全部由字母组成的字符串
 *  @param is YES 是, NO 不是
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isAllAlphabet:(NSString *)txt is:(BOOL)is;

/**
 *  全部由大写字母组成的字符串
 *
 *  @param txt 全部由大写字母组成的字符串
 *  @param is YES 是, NO 不是
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isAllBigAlphabet:(NSString *)txt is:(BOOL)is;

/**
 *  全部由小写字母组成的字符串
 *
 *  @param txt 全部由小写字母组成的字符串
 *  @param is YES 是, NO 不是
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isAllSmallAlphabet:(NSString *)txt is:(BOOL)is;

/**
 *  全部由中文组成的字符串
 *
 *  @param txt 全部由中文组成的字符串
 *  @param is YES 是, NO 不是
 *
 *  @return YES 符合条件, NO 不符合
 */
+ (BOOL)isAllChinese:(NSString *)txt is:(BOOL)is;

/**
 *  匹配是否含有中文
 *
 *  string 字符串文本
 *
 *  @return YES 符合条件, NO 不符合条件
 */
+ (BOOL)isContainChinese:(NSString *)txt;

/**
 *匹配是否含有大小写字母
 */
+ (BOOL)isContainAlphabet:(NSString *)txt;

/**
 *匹配是否含有数字
 */
+ (BOOL)isContainDigital:(NSString *)txt;

/**
 *  匹配身份证号
 *
 *  string 字符串文本
 *  @param type   15位, 18位
 *
 *  @return YES 符合条件, NO 不符合条件
 */
+ (BOOL)isIdentityCard:(NSString *)txt type:(NSInteger)type;

/**
 * 匹配手机号
 *
 *  @param num 数字组成的字符串
 *
 *  @return YES 有效的手机号, NO 无效的手机号
 **/
+ (BOOL)isMobilePhoneWithNum:(NSString *)num;

@end
NS_ASSUME_NONNULL_END
