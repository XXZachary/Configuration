//
//  StringSpliceModel.m
//  JiaKeB
//
//  Created by fuzhaorui on 15/5/28.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import "StringSpliceModel.h"

@implementation StringSpliceModel
+(NSString *)stringSplice:(NSMutableDictionary *)info
{
    NSString *string = @"";
    NSArray *array = [info allKeys];
    for(int i = 0;i<array.count;i++)
    {
        NSString *value = [info objectForKey:array[i]];
        if (i==0) {
            string = [NSString stringWithFormat:@"%@=%@",array[i],value];
        }
        else{
            string = [NSString stringWithFormat:@"%@&%@=%@",string,array[i],value];
        }
    }
    return string;
    
}
@end
