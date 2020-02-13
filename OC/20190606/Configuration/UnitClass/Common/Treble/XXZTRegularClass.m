//
//  XXZTRegularClass.m
//  ConfigurationDemo
//
//  Created by Jiayu_Zachary on 16/9/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZTRegularClass.h"

@implementation XXZTRegularClass

#pragma mark - 三个正则
//由中文 | 字母 | 数字组成
+ (BOOL)isChineseOrAlphabetOrDigital:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9\u4e00-\u9fff]{0,%ld}$", count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

#pragma mark - public
+ (BOOL)evaluateWithRegex:(NSString *)regex txt:(NSString *)txt {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject:txt]) { //匹配
        XXZLog(@"匹配");
        return YES;
    }
    
    XXZLog(@"不匹配");
    return NO;
}

@end
