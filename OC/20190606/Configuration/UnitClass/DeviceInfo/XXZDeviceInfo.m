//
//  XXZDeviceInfo.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/21.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZDeviceInfo.h"

@implementation XXZDeviceInfo

//设备唯一识别符 UDID
+ (NSString *)returnUDID {
    UIDevice *device = [UIDevice currentDevice];
    return [device.identifierForVendor UUIDString];
}

//获取当前系统的版本
+ (NSString *)returnSystemVersion {
    UIDevice *device = [UIDevice currentDevice];
    return device.systemVersion;
}

//获取当前运行的系统名称
+ (NSString *)returnSystemName {
    UIDevice *device = [UIDevice currentDevice];
    return device.systemName;
}

//获取本地化版本
+ (NSString *)returnType {
    UIDevice *device = [UIDevice currentDevice];
    return device.localizedModel;
}

//获取设备的类别
+ (NSString *)returnModel {
    UIDevice *device = [UIDevice currentDevice];
    return device.model;
}

//获取设备所有者的名称
+ (NSString *)retrunName {
    UIDevice *device = [UIDevice currentDevice];
    return device.name;
}

@end
