//
//  TBaseService.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "ECurrentUserInfo.h"
#import "CMStateCodeDefine.h"

@class NSURLSessionTask;
@class KBaseModel;

typedef void (^completion)(BOOL success,id responseObject);
typedef void (^Success)(NSURLSessionDataTask *operation,id responseObject);
typedef void (^Failure)(NSURLSessionDataTask *operation,NSError *error);

@interface KBaseService : NSObject

- (void)requestByModel:(KBaseModel *)model method:(NSString*)method success:(Success)success failure:(Failure)failure;

- (BOOL)responseSuccess:(id)response dict:(NSDictionary **)responseDic isShowAlert:(BOOL)isShow;
- (BOOL)responseGetSuccess:(id)response dict:(NSDictionary **)responseDic isShowAlert:(BOOL)isShow;

@end
