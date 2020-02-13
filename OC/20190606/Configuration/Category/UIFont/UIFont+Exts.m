//
//  UIFont+Exts.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/6/6.
//  Copyright © 2019 www.xxzachary.com. All rights reserved.
//

#import "UIFont+Exts.h"

@implementation UIFont (Exts)

+ (UIFont *)ultraLight:(CGFloat)weight { //极端轻
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightUltraLight];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)thin:(CGFloat)weight { //瘦
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightThin];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)light:(CGFloat)weight { //轻
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightLight];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)regular:(CGFloat)weight { //规则, 即默认
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightRegular];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)medium:(CGFloat)weight { //中等
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightMedium];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)semibold:(CGFloat)weight { //半粗体
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightSemibold];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)bold:(CGFloat)weight { //粗体
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightBold];
    }
    else {
        return [self boldSystemFontOfSize:weight];
    }
}

+ (UIFont *)heavy:(CGFloat)weight { //重粗
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightHeavy];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)black:(CGFloat)weight { //黑体
    if ([self isFlag]) {
        return [self systemFontOfSize:weight weight:UIFontWeightBlack];
    }
    else {
        return [self systemFontOfSize:weight];
    }
}

+ (UIFont *)italic:(CGFloat)weight { //斜体
    return [self italicSystemFontOfSize:weight];
}

#pragma mark - other
+ (BOOL)isFlag { //iOS >= 8.2
    if (FSystemVersion>=8.2) {
        return YES;
    }
    
    return NO;
}

@end
