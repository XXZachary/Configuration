//
//  CertCardType.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/29.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "CertCardType.h"

@implementation CertCardType

//（1：身份证 2: 组织机构代码证 3：护照 4：军官证 5：港澳回乡证或台胞证 6：其他）
+ (NSString *)numToString:(NSInteger)num {
    NSString *cardType = @"";
    
    switch (num) {
        case 1:
        {
            cardType = @"身份证";
        }
            break;
        case 2:
        {
            cardType = @"组织机构代码证";
        }
            break;
        case 3:
        {
            cardType = @"护照";
        }
            break;
        case 4:
        {
            cardType = @"军官证";
        }
            break;
        case 5:
        {
            cardType = @"港澳回乡证或台胞证";
        }
            break;
        case 6:
        {
            cardType = @"其他";
        }
            break;
            
        default:
            break;
    }
    
    return cardType;
}

//（1：身份证 2: 组织机构代码证 3：护照 4：军官证 5：港澳回乡证或台胞证 6：其他）
+ (NSInteger)stringToNum:(NSString *)string {
    NSInteger num = 1; //默认身份证
    
    if ([string isEqualToString:@"身份证"]) {
        num = 1;
    }
    else if ([string isEqualToString:@"组织机构代码证"]){
        num = 2;
    }
    else if ([string isEqualToString:@"护照"]){
        num = 3;
    }
    else if ([string isEqualToString:@"军官证"]){
        num = 4;
    }
    else if ([string isEqualToString:@"港澳回乡证或台胞证"]){
        num = 5;
    }
    else if ([string isEqualToString:@"其他"]){
        num = 6;
    }
    
    return num;
}

@end
