//
//  SignModel.h
//  JiaKeB
//
//  Created by fuzhaorui on 15/5/27.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignModel : NSObject

/**
 *  数据请求签名
 *
 *  @param 信息
 *
 *  @return 32位 的MD5大写
 */
+ (NSString *)acquiresString:(NSMutableDictionary *)info;

/**
 *  微信支付签名
 *
 *  @param 信息
 *
 *  @return 32位 的MD5大写
 */
+ (NSString *)signWeChatPayWithAcquiresString:(NSMutableDictionary *)info;

@end
