//
//  NSString+Exts.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/6/6.
//  Copyright © 2019 www.xxzachary.com. All rights reserved.
//

#import "NSString+Exts.h"

@implementation NSString (Exts)

//判断字符串是否为空
- (NSString *)stringIsEmpty {
    __weak NSString *value = self;
    if ([value isEqual:[NSNull null]]) {
        return @"";
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (nil == value){
        return @"";
    }
    
    return value;
}

//判断对象是否为空
- (BOOL)objectIsEmpty:(id)object {
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (nil == object){
        return YES;
    }
    
    return NO;
}

/**
 * NSRoundPlain, 四舍五入
 * NSRoundDown, 只舍不入
 * NSRoundUp, 只入不舍
 * NSRoundBankers 四舍六入, 中间值时, 取最近的,保持保留最后一位为偶数
 */
- (NSString *)rounding:(NSRoundingMode)mode afterPoint:(int)position {
    __weak NSString *value = self;
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:[value doubleValue]];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end
