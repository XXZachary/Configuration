//
//  SignModel.m
//  JiaKeB
//
//  Created by fuzhaorui on 15/5/27.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import "SignModel.h"
#import "MD5Model.h"

//定值参数key
#define SPKEY  @"c8428d0773fc7a656b7cfcfb0cb4ac62"
//随机获取字符的位数
#define NUMBER_OF_CHARS 1
//每几位后开始插入
#define NUMBER_OF_ECERY  2

@implementation SignModel

#pragma mark - -----------------------------------------------------
+ (NSString *)acquiresString:(NSMutableDictionary *)info
{
    NSString *str = [self createMd5Sign:info];
//    NSLog(@"%@",str);
    
    NSString *returnString = [self stringInsertCharacter:str];
//    NSLog(@"%@",returnString);
    
    return returnString;
}

+ (NSString *)signWeChatPayWithAcquiresString:(NSMutableDictionary *)info {
    NSString *str = [self createMd5Sign:info];
    NSString *returnString = [str uppercaseString];
    
    return returnString;
}

#pragma mark - -----------------------------------------------------
+ (NSString *)createMd5Sign:(NSMutableDictionary*)dict{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
   
    //添加key字段
    [contentString appendFormat:@"key=%@", SPKEY];
    //得到MD5 sign签名
    NSString *md5Sign =[MD5Model md5:contentString];
    
    //输出Debug Info
    // [debugInfo appendFormat:@"MD5签名字符串：\n%@\n\n",contentString];
    
    return md5Sign;
}

//每隔2位插入个随机数
+ (NSString *)stringInsertCharacter:(NSString *)string
{
    NSString *returnString = @"";
    NSMutableArray *stringArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<string.length; i++) {
        [stringArray addObject:[string substringWithRange:NSMakeRange(i,1)]];
    }
    for (int i = 0 ; i<stringArray.count; i++) {
        int j = i%NUMBER_OF_ECERY;
        
        if (i!=0 && j!=0) {
            returnString = [NSString stringWithFormat:@"%@%@%@",returnString,stringArray[i],[self acquiresRandomCharacter]];
        }
        else if(j==0)
        {
            returnString = [NSString stringWithFormat:@"%@%@",returnString,stringArray[i]];
        }
    }
    return returnString;
}
//随机生成一个字母或数字
+ (NSString *)acquiresRandomCharacter
{
    char data[NUMBER_OF_CHARS];
    int type = arc4random()%3;
    if (type == 0) {
        for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('0' + (arc4random_uniform(10))));
    }
    else  if (type == 1) {
        for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('a' + (arc4random_uniform(26))));
    }
    else if (type == 2) {
        for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('A' + (arc4random_uniform(26))));
    }
    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
}

@end
