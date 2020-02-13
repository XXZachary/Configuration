//
//  ChineseString.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/12/1.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "ChineseString.h"
#import "PinYin.h"

@implementation ChineseString

#pragma mark - 返回一组字母(中英混排)和索引(大写字母)的排列数组
+ (NSArray *)sortArray:(NSArray *)stringArr {
    NSMutableArray *tempArray = [self returnSortChineseArray:stringArr];
    
    //把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result=[NSMutableArray array];
    
    //取出对应的大写首字母
    NSMutableArray *bigAlphabetArr = [NSMutableArray array];
    NSString *tempString;
    
    for(int i=0; i<[stringArr count]; i++){
        ChineseString *chineseStr = ((ChineseString*)[tempArray objectAtIndex:i]);
        [result addObject:chineseStr.string];//取文本
        
        //取索引
        NSString *pinyin = [chineseStr.pinYin substringToIndex:1];
        if(![tempString isEqualToString:pinyin]) {//不同
            [bigAlphabetArr addObject:pinyin];
            tempString = pinyin;
        }
    }
    
    return @[result, bigAlphabetArr];
}

#pragma mark - 给排完序的字符串数组分组
+ (NSMutableArray *)letterSortArray:(NSArray *)stringArr {
    NSMutableArray *tempArray = [self returnSortChineseArray:stringArr];
    NSMutableArray *letterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    
    //拼音分组
    for (NSObject *object in tempArray) {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        NSString *contentStr = ((ChineseString*)object).string;
        //不同
        if(![tempString isEqualToString:pinyin]) {
            //分组
            item = [NSMutableArray array];
            [item addObject:contentStr];
            [letterResult addObject:item];
            
            tempString = pinyin;//遍历
        }
        else {//相同
            [item  addObject:contentStr];
        }
    }
    return letterResult;
}

#pragma mark - 索引
+ (NSMutableArray *)indexArray:(NSArray *)stringArr {
    NSMutableArray *tempArray = [self returnSortChineseArray:stringArr];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray) {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin]) {
            [resultArr addObject:pinyin];
            tempString = pinyin;
        }
    }
    
    return resultArr;
}

#pragma mark -
//返回排序好的字符拼音
+ (NSMutableArray *)returnSortChineseArray:(NSArray *)stringArr {
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++) {
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string = stringArr[i];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        //去除两端空格和回车
        chineseString.string  = [chineseString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //一个递归过滤指定字符串   RemoveSpecialCharacter
//        chineseString.string =[ChineseString removeSpecialCharacter:chineseString.string];
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        NSString *initialStr = [chineseString.string length]?[chineseString.string substringToIndex:1]:@"";
        
        if ([predicate evaluateWithObject:initialStr]) {
            //首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
        }
        else{
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c", pinyinFirstLetter([chineseString.string characterAtIndex:j])] uppercaseString];
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin=pinYinResult;
            }
            else{
                chineseString.pinYin=@"";
            }
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    //按照拼音首字母对这些Strings进行升序排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}

//过滤指定字符串, 里面的指定字符根据自己的需要添加
+ (NSString *)removeSpecialCharacter: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    
    if (urgentRange.location != NSNotFound) {
        return [self removeSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    
    return str;
}

@end
