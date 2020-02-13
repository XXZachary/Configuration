//
//  NetworkManager.m
//  Zachary
//
//  Created by Zachary on 2017/4/24.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

//将字典转换成字符串
+ (NSString *)jsonStr:(NSMutableDictionary *)dict have:(BOOL)isHave {
    if (!dict || !dict.count) {
        return @"";
    }
    
    if (isHave) {
        //TOKEN_VALUE, @"AccessToken",
        //AppId, @"AppId",
//        [dict setObject:TOKEN_VALUE forKey:@"AccessToken"];
//        [dict setObject:AppId forKey:@"AppId"];
    }
    
    NSString *jsonStr = @"";
    NSArray *keys = dict.allKeys;
    for (int i=0; i<keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = dict[key];
        
        if (i == 0) {
            jsonStr = [NSString stringWithFormat:@"{%@:\"%@\"", key, value];
        }
        else {
            jsonStr = [jsonStr stringByAppendingString:[NSString stringWithFormat:@", %@:\"%@\"", key, value]];
        }
        
        if (i+1 == keys.count) {
            jsonStr = [jsonStr stringByAppendingString:@"}"];
        }
    }
    
//    XXZLog(@"jsonStr = %@", jsonStr);
    
    return jsonStr;
}

//判断是否为Null
+ (BOOL)isNull:(id)obj {
    BOOL isNull = NO;
    
    if ([obj isKindOfClass:[NSNull class]]) {
        isNull = YES;
    }
    
    return isNull;
}

@end
