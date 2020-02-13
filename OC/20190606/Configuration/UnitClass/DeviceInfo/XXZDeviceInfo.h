//
//  XXZDeviceInfo.h
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/21.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZDeviceInfo : NSObject

//设备唯一识别符 UDID
+ (NSString *)returnUDID;
//获取当前系统的版本
+ (NSString *)returnSystemVersion;
//获取当前运行的系统名称
+ (NSString *)returnSystemName;
//获取本地化版本
+ (NSString *)returnType;
//获取设备的类别
+ (NSString *)returnModel;
//获取设备所有者的名称
+ (NSString *)retrunName;

@end
