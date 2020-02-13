//
//  NetworkManager.h
//  Zachary
//
//  Created by Zachary on 2017/4/24.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

/**
 * 将字典转换成字符串
 */
+ (NSString *)jsonStr:(NSMutableDictionary *)dict have:(BOOL)isHave;

/**
 * 判断是否为Null
 */
+ (BOOL)isNull:(id)obj;

@end
