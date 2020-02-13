//
//  XXZCamera.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "XXZCamera.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation XXZCamera

#pragma mark - 判断相机的权限
+ (NSInteger)isPermissionVisitCamera {
    NSInteger index = -2;
    
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus ==AVAuthorizationStatusRestricted){//-1 受限制
        index = -1;
    }
    else if(authStatus == AVAuthorizationStatusDenied){//0 不允许访问
        index = 0;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//1 允许访问
        index = 1;
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){//2 还没决定
        index = 2;
    }
    else {//-2 其他情况
        index = -2;
    }
    
    return index;
}

#pragma mark - 判断相册的权限
+ (NSInteger)isPermissionVisitLibrary {
    NSInteger index = -2;
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if(authStatus ==AVAuthorizationStatusRestricted){//-1 受限制
        index = -1;
    }
    else if(authStatus == AVAuthorizationStatusDenied){//0 不允许访问
        index = 0;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//1 允许访问
        index = 1;
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){//2 还没决定
        index = 2;
    }
    else {//-2 其他情况
        index = -2;
    }
    
    return index;
}

//是否有定位权限
+ (BOOL)isPermissionVisitLocation {
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //没有定位权限
        return NO;
    }
    
    return YES;
}

//是否有摄像头权限
+ (NSInteger)isPermissionVisitMedia {
    AVAuthorizationStatus statusVideo = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (statusVideo == AVAuthorizationStatusDenied) {
        //没有摄像头权限
        return NO;
    }
    
    return YES;
}

//是否有麦克风权限
+ (NSInteger)isPermissionVisitAudio {
    AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (statusAudio == AVAuthorizationStatusDenied) {
        //没有录音权限
        return NO;
    }
    
    return YES;
}

@end
