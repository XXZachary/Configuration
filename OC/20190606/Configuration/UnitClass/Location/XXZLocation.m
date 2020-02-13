

//
//  XXZLocation.m
//  MyMap
//
//  Created by Jiayu_Zachary on 16/7/27.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZLocation.h"
#import <CoreLocation/CoreLocation.h>

@implementation XXZLocation

//YES 定位权限开启, NO 定位权限关闭
+ (BOOL)isOpenLocationAuthority {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        return YES;
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return NO;
    }
    
    return NO;
}

@end
