//
//  KService.m
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import "KService.h"

@implementation KService

+ (instancetype)SELF {
    static dispatch_once_t onceToken;
    static KService *kService = nil;
    
    dispatch_once(&onceToken, ^{
        kService = [[KService alloc] init];
    });
    
    return kService;
}

#pragma mark - Zachary - core process
//POST
+ (void)coreProcess:(NSString *)responseStr  model:(KBaseModel *)model Completion:(completion)completion {
    [[self SELF] requestByModel:model method:@"POST" success:^(NSURLSessionTask *operation, id responseObject) {
        
        NSDictionary *dic_   = nil;
        BOOL isSuccess = [[self SELF] responseSuccess:responseObject dict:&dic_ isShowAlert:NO];
        
        //解析并新建对应的Response
        Class cls_ = NSClassFromString(responseStr);
        id instance = [[cls_ alloc] init];
        
        if (isSuccess && dic_) {
            //解析并新建对应的Response
            SEL selector = @selector(initWithResponse:);
            NSMethodSignature *sig = [instance methodSignatureForSelector:selector];
            if (sig) {
                NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
                [invocation setTarget:instance];
                [invocation setSelector:selector];
                [invocation setArgument:&dic_ atIndex:2];
                [invocation invoke];
                
                if (sig.methodReturnLength) {
                    CFTypeRef result;
                    [invocation getReturnValue:&result];
                    CFRetain(result);
                    instance = (__bridge_transfer id)result;
                }
                
                completion(YES, instance);
            }
            else{
                completion(NO, dic_);
            }
        }
        else {
            if (dic_) { //需要处理额外的错误代码
                if ([instance respondsToSelector:@selector(setState:)]) {
                    [instance performSelector:@selector(setState:) withObject:[dic_ stringForKeyNotNull:KBaseResponse_State]];
                }
                
                if ([instance respondsToSelector:@selector(setMessage:)]) {
                    [instance performSelector:@selector(setMessage:) withObject:[dic_ stringForKeyNotNull:KBaseResponse_Message]];
                }
                
                completion(NO, instance);
            }
            else{
                completion(NO, nil);
            }
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(NO,nil);
    }];
}

//GET
+ (void)coreGetProcess:(NSString *)responseStr  model:(KBaseModel *)model Completion:(completion)completion {
    [[self SELF] requestByModel:model method:@"GET" success:^(NSURLSessionTask *operation, id responseObject) {
        
        NSDictionary  *dic_   = nil;
        BOOL isSuccess = [[self SELF] responseGetSuccess:responseObject dict:&dic_ isShowAlert:NO];
        
        //解析并新建对应的Response
        Class cls_ = NSClassFromString(responseStr);
        id instance = [cls_ alloc];
        instance = [instance init];
        
        if (isSuccess && dic_) {
            //解析并新建对应的Response
            SEL selector = @selector(initWithResponse:);
            NSMethodSignature *sig = [instance methodSignatureForSelector:selector];
            
            if (sig) {
                NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
                [invocation setTarget:instance];
                [invocation setSelector:selector];
                [invocation setArgument:&dic_ atIndex:2];
                [invocation invoke];
                
                if (sig.methodReturnLength) {
                    CFTypeRef result;
                    [invocation getReturnValue:&result];
                    CFRetain(result);
                    instance = (__bridge_transfer id)result;
                }
                completion(YES, instance);
            }
            else {
                completion(NO, dic_);
            }
        }
        else {
            if (dic_) { //需要处理额外的错误代码
                if ([instance respondsToSelector:@selector(setState:)]) {
                    [instance performSelector:@selector(setState:) withObject:[dic_ stringForKeyNotNull:KBaseResponse_State]];
                }
                
                if ([instance respondsToSelector:@selector(setMessage:)]) {
                    [instance performSelector:@selector(setMessage:) withObject:[dic_ stringForKeyNotNull:KBaseResponse_Message]];
                }
                
                completion(NO, instance);
            }
            else {
                completion(NO, nil);
            }
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(NO, nil);
    }];
}

@end
