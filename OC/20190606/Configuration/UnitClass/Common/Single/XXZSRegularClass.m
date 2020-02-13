//
//  XXZSRegularClass.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzd.future. All rights reserved.
//

#import "XXZSRegularClass.h"

@implementation XXZSRegularClass

#pragma mark - 单一正则
//邮箱验证: NO 不符合, YES 符合
+ (BOOL)isValidateEmail:(NSString *)email{
    if (IS_BLANK_STRING(email)) return NO;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    return [self evaluateWithRegex:emailRegex txt:email];
}

//全部由数字组成的字符串; is = YES 是, NO 不是
+ (BOOL)isAllDigital:(NSString *)txt is:(BOOL)is {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *temp = nil;
    
    if (is) temp = @"\\d"; //全部是由数字组成的字符串 => [0-9]
    else temp = @"\\D"; //全部都不是数字组成的字符串 => [^0-9]
    
    NSString *regex = [NSString stringWithFormat:@"^%@{0,%ld}$", temp, count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//全部由字母组成的字符串; is = YES 是, NO 不是
+ (BOOL)isAllAlphabet:(NSString *)txt is:(BOOL)is {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *temp = nil;
    
    if (is) temp = @"[a-zA-Z]"; //全部是由字母组成的字符串
    else temp = @"[^a-zA-Z]"; //全部都不是字母组成的字符串
    
    NSString *regex = [NSString stringWithFormat:@"^%@{0,%ld}$", temp, count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//全部由大写字母组成的字符串; is = YES 是, NO 不是
+ (BOOL)isAllBigAlphabet:(NSString *)txt is:(BOOL)is {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *temp = nil;
    
    if (is) temp = @"[A-Z]"; //全部是由大写字母组成的字符串
    else temp = @"[^A-Z]"; //全部都不是大写字母组成的字符串
    
    NSString *regex = [NSString stringWithFormat:@"^%@{0,%ld}$", temp, count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//全部由小写字母组成的字符串; is = YES 是, NO 不是
+ (BOOL)isAllSmallAlphabet:(NSString *)txt is:(BOOL)is {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *temp = nil;
    
    if (is) temp = @"[a-z]"; //全部是由小写字母组成的字符串
    else temp = @"[^a-z]"; //全部都不是小写字母组成的字符串
    
    NSString *regex = [NSString stringWithFormat:@"^%@{0,%ld}$", temp, count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//全部由中文组成的字符串; is = YES 是, NO 不是
+ (BOOL)isAllChinese:(NSString *)txt is:(BOOL)is {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSInteger count = txt.length;
    NSString *temp = nil;
    
    if (is) temp = @"[\u4e00-\u9fff]"; //全部是由中文组成的字符串
    else temp = @"[^\u4e00-\u9fff]"; //全部都不是中文组成的字符串
    
    NSString *regex = [NSString stringWithFormat:@"^%@{0,%ld}$", temp, count];
    
    return [self evaluateWithRegex:regex txt:txt];
}

//匹配是否含有中文
+ (BOOL)isContainChinese:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    for(int i=0; i< [txt length];i++){
        int a = [txt characterAtIndex:i];
        
        if((a > 0x4e00 && a < 0x9fff)) {
            return YES; //含有
        }
    }
    
    return NO; //不含有
}

//匹配是否含有大小写字母
+ (BOOL)isContainAlphabet:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    for(int i=0; i< [txt length];i++){
        int a = [txt characterAtIndex:i];
        
        if ((a >= 'a' && a <= 'z') || (a >= 'A' && a <= 'Z')) {
            return YES; //含有
        }
    }
    
    return NO;
}

//匹配是否含有数字
+ (BOOL)isContainDigital:(NSString *)txt {
    if (IS_BLANK_STRING(txt)) return NO;
    
    for(int i=0; i< [txt length];i++){
        int a = [txt characterAtIndex:i];
        
        if (a >= '0' && a <= '9') {
            return YES; //含有
        }
    }
    
    return NO;
}

//匹配身份证号; 分一代15位和二代18位
+ (BOOL)isIdentityCard:(NSString *)txt type:(NSInteger)type {
    if (IS_BLANK_STRING(txt)) return NO;
    
    NSString *isIDCard = nil;
    if (type == 15) { //15位数身份证验证正则表达式：
        isIDCard = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    }
    else { //18位数身份证验证正则表达式 ：
        isIDCard = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    }
    
    return [self evaluateWithRegex:isIDCard txt:txt];
}

//匹配手机号
+ (BOOL)isMobilePhoneWithNum:(NSString *)num {
    if (IS_BLANK_STRING(num)) return NO;
    
    //^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|17[0-9])\d{8}$
    //    NSString *regex = @"^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])\\d{8}$";
    NSString *regex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    return [self evaluateWithRegex:regex txt:num];
}

//未完待续...


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
