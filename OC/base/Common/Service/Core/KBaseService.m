//
//  KBaseService.m
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import <AFNetworking/AFURLResponseSerialization.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "AFNetworking.h"
#import "OpenUDID.h"
#import "TUtility.h"

#import "KBaseService.h"
#import "KBaseModel.h"
#import "KBaseResponse.h"

#import "NSDictionary+stringForKey.h"
#import "NSDictionary_JSONExtensions.h"
#import "NSString+ThreeDES.h"
#import "NSDate+changeTo16bit.h"

#import "AppDelegate+Login.h"

#define API_KEY @"Carwish"
#define HttpUrlHost    @"http://www.carwish.cn/index.php/api" //主域名
static NSString * const APIBaseURLString = HttpUrlHost;

//0 企业版本 1 商店版本
#define __AppStoreChannel__ (0)

#if __AppStoreChannel__
//商店版本
#define __Channel__ @"AppStore"

#define CMAPPVersion    @"40"
#define CMAPIVersion    @"1"

#else
//企业版本
#define __Channel__ @"OutAppStore"

// outappstore
#define CMAPPVersion    @"41"
#define CMAPIVersion    @"1"

#endif

@implementation KBaseService

- (AFHTTPSessionManager *)sharedInstanceHttpManager{
    
    static AFHTTPSessionManager *httpRequestOperationManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        httpRequestOperationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        //securityPolicy
        httpRequestOperationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        //responseSerializer
        httpRequestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        httpRequestOperationManager.requestSerializer.timeoutInterval = 30.0;
        
        //requestSerializer
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
	    NSString *systemVersion = [NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]];
        NSString *deviceType = [[TUtility sharedManager] platformString];
        [httpRequestOperationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [httpRequestOperationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil] ];
        
        [httpRequestOperationManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"systemType"];
        [httpRequestOperationManager.requestSerializer setValue:systemVersion forHTTPHeaderField:@"systemVersion"];
        [httpRequestOperationManager.requestSerializer setValue:currentVersion forHTTPHeaderField:@"clientVersion"];
        [httpRequestOperationManager.requestSerializer setValue:deviceType forHTTPHeaderField:@"deviceType"];
        [httpRequestOperationManager.requestSerializer setValue:CMAPIVersion forHTTPHeaderField:@"apiVersion"];
        [httpRequestOperationManager.requestSerializer setValue:CMAPPVersion forHTTPHeaderField:@"appVersion"];
	    NSString *udid_ = [OpenUDID value]==nil?@"":[OpenUDID value];
	    [httpRequestOperationManager.requestSerializer setValue:udid_ forHTTPHeaderField:@"deviceId"];

        [httpRequestOperationManager.requestSerializer setValue:__Channel__ forHTTPHeaderField:@"channel"];

	    //networkReachabilityManager
    });
    
    return httpRequestOperationManager;
}

- (NSString *)getSha1String:(NSString *)requestUrl withRequestDate:(NSDate *)date {

	NSString *originStr = [NSString stringWithFormat:@"%@%@%@", API_KEY, [requestUrl lowercaseString], [date changeTo16bit] ];

	NSString *returnStr = [originStr sha1];
	return returnStr;
}

- (void)requestByModel:(KBaseModel*)model method:(NSString*)method success:(Success)success failure:(Failure)failure{
    NSString *url = [model getPostRequestURL];
	AFHTTPSessionManager *sessionManager = [self sharedInstanceHttpManager];

//    if([[ECurrentUserInfo sharedInstance] isLogined]&&![[model getPostRequestURL] isEqualToString:@"shenxun_sms_app/smsSend"]){
//        //用户已经登录，并且请求的接口不是登录接口
//        [sessionManager.requestSerializer setValue:[ECurrentUserInfo sharedInstance].cmUserId forHTTPHeaderField:@"coach_id"];
//    }
//    else{
//        [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"coach_id"];
//    }

    NSDate *requestDate = [NSDate date];

    NSString *Apitoken = [self getSha1String:[model getPostRequestURL] withRequestDate:requestDate ];
    NSString *Extime = [NSString stringWithFormat:@"%ld",@(requestDate.timeIntervalSince1970).integerValue];
    [sessionManager.requestSerializer setValue:Extime forHTTPHeaderField:@"Extime"];
    [sessionManager.requestSerializer setValue:Apitoken forHTTPHeaderField:@"Apitoken"];

    if ([method isEqualToString:@"GET"]) {
        
        [sessionManager GET:url parameters:[model changeToDic] progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(task, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            XXZLog(@"in failure operation response is %@",error);
            failure(task, error);
            
        }];
    }
    else if ([method isEqualToString:@"POST"]){
        [sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData throttleBandwidthWithPacketSize:kAFUploadStream3GSuggestedPacketSize delay:kAFUploadStream3GSuggestedDelay];
            
            //NSString *body = [model encrypt_body]; //数据加密
            NSString *body = [model no_encrypt_body]; //非数据加密
            NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:data name:@"body"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(task, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //网络请求失败提示框
            XZLog(@"in failure operation response is %@ \n", error);
            failure(task, error);
        }];
    }
}

- (BOOL)responseSuccess:(id)response dict:(NSDictionary **)responseDic isShowAlert:(BOOL)isShow {
//    NSString *responseStr = [self useThreeDES_decode:response];
    NSString *responseStr = [self no_useThreeDES_decode:response];
    NSError *error;
    *responseDic = [NSDictionary dictionaryWithJSONString:responseStr error:&error];
    if(error){
        XZLog(@"post无法解析 responseObject error is %@", error);
    }
    
    if (*responseDic) {
        NSString *state = [*responseDic stringForKeyNotNull:KBaseResponse_State];
        NSString *message = [*responseDic stringForKeyNotNull:KBaseResponse_Message];

        if (state.integerValue == 0) {//success
            if (isShow == YES) { //提示框
                [QMUITips showInfo:message inView:DefaultTipsParentView hideAfterDelay:2.0];
            }
            
            return YES;
        }
        else {
            if((state.integerValue == kErr_CMStateCode_NeedLogin1) || (state.integerValue == kErr_CMStateCode_NeedLogin2) || (state.integerValue == kErr_CMStateCode_NeedLogin3)){
                [[ECurrentUserInfo sharedInstance] logout];
                [[AppDelegate shareAppDelegate] switchAppLogin];
            }
            else if (state.integerValue == kErr_CMStateCode_NeedUpdate){
                
            }
            else{
                
            }

            return NO;
        }
    }
    else {
        //提示框
        return NO;
    }
}

- (BOOL)responseGetSuccess:(id)response dict:(NSDictionary **)responseDic isShowAlert:(BOOL)isShow{
    NSError *error = nil;
    *responseDic = [NSDictionary dictionaryWithJSONData:response error:&error];
    if(error){
        XZLog(@"get无法解析 responseObject error is %@", error);
    }
    
    if (*responseDic) {
        NSString *state = [*responseDic stringForKeyNotNull:KBaseResponse_State];
        NSString *message = [*responseDic stringForKeyNotNull:KBaseResponse_Message];
        
        if (state.integerValue == 0) {//success
            if (isShow == YES) { //提示框
                [QMUITips showInfo:message inView:DefaultTipsParentView hideAfterDelay:2.0];
            }
            
            return YES;
        }
        else{
            if((state.integerValue == kErr_CMStateCode_NeedLogin1) || (state.integerValue == kErr_CMStateCode_NeedLogin2) || (state.integerValue == kErr_CMStateCode_NeedLogin3)){
                [[ECurrentUserInfo sharedInstance] logout];
                [[AppDelegate shareAppDelegate] switchAppLogin];
            }
            else if (state.integerValue == kErr_CMStateCode_NeedUpdate){
                
            }
            else{
                
            }
            return NO;
        }
    }
    else {
        //提示框
        return NO;
    }
}

//解析加密数据
- (NSString *)useThreeDES_decode:(NSData *)rSource {
    NSString *stringBefore = [[NSString alloc] initWithData:rSource encoding:NSUTF8StringEncoding];
//    if([stringBefore hasPrefix:@"success"]){
//        stringBefore = [stringBefore substringFromIndex:7];
//    }
    NSString *decode_str = [NSString decrypt:stringBefore];
    
    return decode_str;
}

//解析未加密数据
- (NSString *)no_useThreeDES_decode:(NSData *)rSource {
    NSString *stringBefore = [[NSString alloc] initWithData:rSource encoding:NSUTF8StringEncoding];
    return stringBefore;
}


//返回的数据结果
/*
 //数据转换格式
 NSData *data = (NSData*)responseObject;
 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
 */

@end
