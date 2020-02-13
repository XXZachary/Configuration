//
//  XXZUserIdInfo.m
//  Easy2Car
//
//  Created by Zachary on 2018/11/22.
//  Copyright © 2018 www.xxzachary.com. All rights reserved.
//

#import "XXZUserIdInfo.h"

@implementation XXZUserIdInfo

//根据身份证获取年龄
+ (NSString *)getIdentityCardAge:(NSString *)cardNum {
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];

    NSMutableDictionary *birthday = [self getIdentityCardBirthday:cardNum];
    NSString *birthdayStr = [NSString stringWithFormat:@"%@-%@-%@", birthday[@"year"], birthday[@"month"], birthday[@"day"]];
    NSDate *bsyDate = [formatterTow dateFromString:birthdayStr];

    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;

    return [NSString stringWithFormat:@"%d",-age];
}

//获取生日
+ (NSMutableDictionary *)getIdentityCardBirthday:(NSString *)cardNum {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([cardNum length]<18) return result;
    
    //**从第6位开始 截取8个数
    NSString *fontNumer = [cardNum substringWithRange:NSMakeRange(6, 8)];
    
    //**检测前12位否全都是数字;
    
    const char *str = [fontNumer UTF8String];
    
    const char *p = str;
    
    while (*p!='\0') {
        
        if(!(*p>='0'&&*p<='9'))
            
            isAllNumber = NO;
        
        p++;
        
    }
    
    if(!isAllNumber) return result;

    year = [NSString stringWithFormat:@"19%@", [cardNum substringWithRange:NSMakeRange(8, 2)]];
    month = [cardNum substringWithRange:NSMakeRange(10, 2)];
    day = [cardNum substringWithRange:NSMakeRange(12,2)];
    
    [result setObject:year forKey:@"year"];
    [result setObject:month forKey:@"month"];
    [result setObject:day forKey:@"day"];
    
    return result;
}

//获取性别: 1 男, 2 女
+ (NSString *)getIdentityCardSex:(NSString *)cardNum {
    NSString *sex = @"";
    
    //获取18位 二代身份证  性别
    if (cardNum.length==18) {
        int sexInt=[[cardNum substringWithRange:NSMakeRange(16,1)] intValue];
        
        if(sexInt%2!=0) { //奇男, 偶女
            sex = @"1";
        }
        else {
            sex = @"2";
        }
    }

    //  获取15位 一代身份证  性别
    if (cardNum.length==15) {
        int sexInt=[[cardNum substringWithRange:NSMakeRange(14,1)] intValue];
        
        if(sexInt%2!=0) {
            sex = @"1";
        }
        else {
            sex = @"2";
        }
    }
    
    return sex;
}

@end
