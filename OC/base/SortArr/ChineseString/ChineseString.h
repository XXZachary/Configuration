//
//  ChineseString.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/12/1.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseString : NSObject

@property(retain,nonatomic) NSString *string;
@property(retain,nonatomic) NSString *pinYin;

/**
 *  文本对应的索引
 *
 *  @param NSMutableArray 字符串数组
 *
 *  @return 排完序后的大写字母, 第0个元素是"#"
 */
+ (NSMutableArray *)indexArray:(NSArray *)stringArr;

/**
 *  给排完序的字符串数组分组
 *
 *  @param stringArr 排完序的字符串数组
 *
 *  @return 分完组的字符串数组
 */
+ (NSMutableArray *)letterSortArray:(NSArray *)stringArr;

/**
 *  返回一组字母(中英混排)和索引(大写字母)的排列数组
 *
 *  @param stringArr 字符串数组
 *
 *  @return 两个数组元素, 0 分组排完序的文本, 1 分组排完序的索引(第0个元素是"#")
 */
+ (NSArray *)sortArray:(NSArray *)stringArr;

@end
