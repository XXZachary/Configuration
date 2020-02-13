//
//  XXZDRegularClass.m
//  ConfigurationDemo
//
//  Created by Jiayu_Zachary on 16/9/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZDRegularClass.h"

@implementation XXZDRegularClass

#pragma mark - 两个正则
//由字母 | 数字组成
+ (BOOL)isAlphabetOrDigital:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *regex = [NSString stringWithFormat: @"^[A-Za-z0-9]{0,%ld}$", (long)count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//由中文 | 字母组成
+ (BOOL)isChineseOrAlphabet:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *regex = [NSString stringWithFormat:@"^[A-Za-z\u4e00-\u9fff]{0,%ld}$", count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//由中文 | 数字组成
+ (BOOL)isChineseOrDigital:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *regex = [NSString stringWithFormat:@"^[0-9\u4e00-\u9fff]{0,%ld}$", count];
    
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
