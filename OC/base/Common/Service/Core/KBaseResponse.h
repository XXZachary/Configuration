//
//  KBaseResponse.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+stringForKey.h"

#define KBaseResponse_State      @"code"
#define KBaseResponse_Message    @"msg"
#define KBaseResponse_Data       @"data"

@interface KBaseResponse : NSObject<NSCoding>

@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *message;

//解包原始数据, 返回字典
- (NSDictionary *)decodeData:(NSDictionary *)dic;
//解包原始数据, 返回数组
- (NSArray *)decodeArrayData:(NSDictionary *)dic;

- (id)initWithResponse:(NSDictionary *)responseDic;

@end
