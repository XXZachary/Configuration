//
//  XXZStringClass.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzd.future. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface XXZStringClass : NSObject

#pragma mark - 字符串的操作
/**
 *  混合颜色
 *
 *  @param color1 颜色1
 *  @param color2 颜色2
 *  @param ratio 0~1
 *
 *  @return 颜色的对象; nil 参数错误
 */
+ (UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio;

/**
 *  字符串颜色转换成UIColor
 *
 *  @param string 颜色字符串
 *
 *  @return 颜色的对象; nil 参数错误
 */
+ (UIColor *)colorWithString:(NSString *)string;

/**
 *  判断字符串是否为空或并空格
 *
 *  @param string 字符串文本
 *
 *  @return NO 有内容; YES 没有内容或空格
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  数字字符串格式
 *
 *  str 数字字符串文本
 *  style 数字格式
 *
 *  @return 返回值
 */
+ (NSString *)stringStyleWithStr:(NSString *)str style:(NSNumberFormatterStyle)style;

/**
 *  对字符串进行操作
 *
 *  @param string       源字符串
 *  @param colorArr   UIColor
 *  @param fontArr    UIFont
 *  @param rangeArr  NSRange
 *
 *  @return 操作后的字符串, nil 则输入参数不对
 */
+ (NSAttributedString *)editWithString:(NSString *)string colorArray:(nullable NSArray *)colorArr fontArray:(nullable NSArray *)fontArr range:(NSArray *)rangeArr;

#pragma mark - Zachary - attribued string
/**
 * 计算字符串宽高
 * font 字体
 * lSpacing 行间距
 * maxSize 文本显示区域
 * text 文本
 */
+ (CGSize)calculateStringHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing maxSize:(CGSize)maxSize text:(NSString *)text;

/**
 * 富文本设置
 * font 字体
 * lSpacing 行间距
 * text 文本
 */
+ (NSMutableAttributedString *)attributedWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing text:(NSString *)text;

/**
 * 配置富文本属性
 * font 字体
 * lSpacing 行间距
 */
+ (NSDictionary *)attributesWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing;

#pragma mark - 字符串排序
/**
 *  将中文字符串数组转换成中文拼音首字母字符串数组
 *
 *  @param array 全是中文字符串数组
 *  @param isUp  YES 大写, NO 小写
 *
 *  @return array中每个字符串中每个中文的首字母 组合成 拼音字符串的数组
 */
+ (NSMutableArray *)convertChineseStringToPinyinWithArray:(NSArray *)array uppercaseString:(BOOL)isUp;


/**
 *  将中文字符串转换成中文拼音首字母字符串
 *
 *  @param string 中文字符串
 *  @param isUp   YES 大写, NO 小写
 *
 *  @return 中文字符串中每个中文的首字母 组合成 中文拼音首字母字符串
 */
+ (NSString *)convertSingleChineseStringToPinyinWithString:(NSString *)string uppercaseString:(BOOL)isUp;

/**
 *  将中文字符串转换成中文拼音首字母是大写的字符串
 *
 *  @param string 中文字符串
 *  @param isUp   YES 大写, NO 小写
 *
 *  @return 中文字符串中每个中文的首字母 组合成 中文拼音首字母字符串
 */
+ (NSString *)convertChineseStringToPinyinWithString:(NSString *)string uppercaseString:(BOOL)isUp;

/**
 *  按字母或数字顺序排序
 *
 *  @param array       字母字符串数组
 *  @param isAscending YES 升序排列, NO 降序排列
 *
 *  @return 排完序的字符串数组
 */
+ (NSArray *)sortWithArray:(NSArray *)array orderAscending:(BOOL)isAscending;

#pragma mark - 生成随机数
/**
 *  随机生成num个字母或数字组成的字符串(大写,小写或数字)
 *
 *  @param num 个数
 *
 *  @return 随机数num长度的字符串
 */
+ (NSString *)randomStringWithNumber:(NSInteger)num;

#pragma mark - 加逗号
/**
 *  加入逗号分隔符
 *
 *  @param content 字符串,不含小数点至少三位以上, 才会加入逗号","
 *
 *  @return 加入逗号后的字符串
 */
+ (NSString *)addCommaInString:(NSString *)content;

#pragma mark - 判断一个字符串是否包含另一个字符串
/**
 *  判断一个字符串是否包含另一个字符串
 *
 *  @param str 包含者字符串
 *  @param str1 被包含者字符串
 *
 *  @return YES 包含, NO 不包含
 */
+ (BOOL)str:(NSString *)str isContainString:(NSString *)str1;

#pragma mark - 获取字符串中的数字
/**
 *  获取字符串中的数字
 *
 *  @param str 字符串
 *
 *  @return 数字字符串
 */
- (NSString *)getNumberFromStr:(NSString *)str;

#pragma mark - 移除字符串中的空格和换行
/**
 *  移除字符串中的空格和换行
 *
 *  @param str 字符串
 *
 *  @return 字符串
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

#pragma mark - 其他

@end

NS_ASSUME_NONNULL_END
