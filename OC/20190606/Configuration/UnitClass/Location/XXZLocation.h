//
//  XXZLocation.h
//  MyMap
//
//  Created by Jiayu_Zachary on 16/7/27.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZLocation : NSObject

/**
 *  YES 定位权限开启, NO 定位权限关闭
 *
 *  @return YES 定位权限开启, NO 定位权限关闭
 */
+ (BOOL)isOpenLocationAuthority;

@end
