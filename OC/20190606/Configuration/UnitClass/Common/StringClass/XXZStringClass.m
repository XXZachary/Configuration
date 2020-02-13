//
//  XXZStringClass.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzd.future. All rights reserved.
//

#import "XXZStringClass.h"

@implementation XXZStringClass

#pragma mark - 字符串操作
//混合颜色,ratio 0~1
+ (UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio {
    if(ratio > 1)
        ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    
    NSLog(@"ratio = %f",ratio);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    //    CGFloat alpha = components1[3]*ratio + components2[3]*(1-ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

//字符串颜色转换成UIColor
+ (UIColor *)colorWithString:(NSString *)string {
    if (IS_BLANK_STRING(string)) return nil;
    
    unsigned red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[string substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[string substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[string substringWithRange:range]] scanHexInt:&blue];
    
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

//判断字符串为空和只为空格; 返回YES 则为空或空格
+ (BOOL)isBlankString:(NSString *)string {
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

/**
 *
 * NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle, //94863
 *
 * NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle, //94,862.57
 *
 * NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle, //￥94,862.57
 *
 * NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle, //9,486,257%
 *
 * NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle, //9.486257E4
 *
 * NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle //九万四千八百六十二点五七
 */
+ (NSString *)stringStyleWithStr:(NSString *)str style:(NSNumberFormatterStyle)style {
    // 判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || IS_BLANK_STRING(str))) {
        str = @"0";
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = style;
    
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    return money;
}

//对字符串进行操作
//colorArr => UIColor, fontArr => UIFont, rangeArr => NSRange
+ (NSAttributedString *)editWithString:(NSString *)string colorArray:(NSArray *)colorArr fontArray:(NSArray *)fontArr range:(NSArray *)rangeArr{
    if (IS_BLANK_STRING(string)) return nil;
    
    //若指定部分没有数据,返回nil
    if (!rangeArr.count) return nil;
    if (!colorArr.count && !fontArr.count) return nil;
    
    //初始化字符串
    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:string];
    
    NSInteger colorCount = colorArr.count;
    NSInteger fontCount = fontArr.count;
    NSInteger rangeCount = rangeArr.count;
    
    //改变颜色
    if (colorCount && colorCount == rangeCount) {
        for (int i=0; i<rangeCount; i++) {
            
            /*
             //1 - 阴影
             NSShadow *shadow = [[NSShadow alloc] init];
             shadow.shadowColor = [UIColor cyanColor];
             shadow.shadowOffset = CGSizeMake(0, 5);
             shadow.shadowBlurRadius = 15.0;//阴影
             
             //NSShadowAttributeName:shadow
             */
            
            /*
             //2 - 删除线
             NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:1],
             //NSUnderlineStyleNone
             NSStrikethroughColorAttributeName:[UIColor blackColor], //删除线颜色
             */
            
            /*
             //3 - 下划线
             NSUnderlineStyleAttributeName:[NSNumber numberWithInt:0x01],
             NSUnderlineColorAttributeName:[UIColor blackColor], //下划线颜色
             */
            
            /*
             //4 - 空心字
             NSStrokeWidthAttributeName:[NSNumber numberWithInt:3],
             */
            
            //颜色
            NSDictionary *attribute = @{
                                        NSForegroundColorAttributeName:[colorArr objectAtIndex:i]};
            //指定部分
            NSRange range = NSRangeFromString([rangeArr objectAtIndex:i]);
            //判断指定部分是否越界
            if (range.length > string.length || range.location+1 > string.length || (range.length+range.location > string.length)) {
                XXZLog(@"越界");
                return nil;
            }
            //change
            [attributedText addAttributes:attribute range:range];
        }
    }
    
    //改变字体
    if (fontCount && fontCount == rangeCount) {
        for (int i=0; i<rangeCount; i++) {
            //字体
            NSDictionary *attribute = @{NSFontAttributeName:[fontArr objectAtIndex:i]};
            //指定部分
            NSRange range = NSRangeFromString([rangeArr objectAtIndex:i]);
            //判断指定部分是否越界
            if (range.length > string.length || range.location+1 > string.length || (range.length+range.location > string.length)) {
                XXZLog(@"越界");
                return nil;
            }
            //change
            [attributedText addAttributes:attribute range:range];
        }
    }
    
    return attributedText;
}

#pragma mark - Zachary - attribued string
//计算字符串高
+ (CGSize)calculateStringHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing maxSize:(CGSize)maxSize text:(NSString *)text {
    NSDictionary *dict = [self attributesWithFont:font lineSpacing:lSpacing];
    CGSize size = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        size = [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:dict context:nil].size;
        size.height += 0.5; //误差
    }
    else {
        XXZLog(@"不支持iOS 7.0 以下的系统..");
    }
    
    return size;
}

//富文本设置
+ (NSMutableAttributedString *)attributedWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing text:(NSString *)text {
    NSDictionary *dict = [self attributesWithFont:font lineSpacing:lSpacing];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
    
    return attri;
}

//配置富文本属性
+ (NSDictionary *)attributesWithFont:(UIFont *)font lineSpacing:(CGFloat)lSpacing {
    //段落
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping; //结尾部分的内容以…方式省略
    paraStyle.alignment = NSTextAlignmentLeft; //对齐
    paraStyle.lineSpacing = lSpacing; //行间距
    paraStyle.hyphenationFactor = 1.0; //连字属性 在iOS，唯一支持的值分别为0和1
    paraStyle.firstLineHeadIndent = 0.0; //首行缩进
    paraStyle.headIndent = 0; //整体缩进(首行除外)
    paraStyle.tailIndent = 0; //尾部缩进
    paraStyle.paragraphSpacingBefore = 0.0; //段首行空白空间
    //paraStyle.minimumLineHeight = 10; //最低行高
    //paraStyle.maximumLineHeight = 20; //最大行高
    //paraStyle.paragraphSpacing = 15.0; //段与段之间的间距
    
    //富文本属性
    NSDictionary *dict = @{
                           NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paraStyle,
                           NSKernAttributeName: @(1.f) //字间距
                           };
    
    return dict;
}

#pragma mark - 字符串排序
//将单个中文字符串转换成中文拼音首字母字符串
//isUp = YES 大写, NO 小写
+ (NSString *)convertSingleChineseStringToPinyinWithString:(NSString *)string uppercaseString:(BOOL)isUp {
    if (!string.length) return nil;
    
    NSString *needStr = nil;
    for (int i=0; i<string.length; i++) {
        //截取一个中文
        NSString *singleStr = [string substringWithRange:NSMakeRange(i, 1)];
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:singleStr];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        
        //转化为大写拼音
        NSString *pinYin = nil;
        if (isUp) {
            pinYin = [str capitalizedString];
        }else {
            pinYin = [str lowercaseString];
        }
        
        //截取每个中文的首字母
        if (needStr.length) {
            needStr = [needStr stringByAppendingFormat:@"%@", [pinYin substringToIndex:1]];
        }else {
            needStr = [pinYin substringToIndex:1];
        }
    }
    
    return needStr;
}

//将单个中文字符串转换成中文拼音首字母字符串
//isUp = YES 大写, NO 小写
+ (NSString *)convertChineseStringToPinyinWithString:(NSString *)string uppercaseString:(BOOL)isUp {
    if (!string.length) return nil;
    
    NSString *needStr = nil;
    for (int i=0; i<string.length; i++) {
        //截取一个中文
        NSString *singleStr = [string substringWithRange:NSMakeRange(i, 1)];
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:singleStr];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        
        //转化为大写拼音
        NSString *pinYin = nil;
        if (isUp) {
            pinYin = [str capitalizedString];
        }else {
            pinYin = [str lowercaseString];
        }
        
        //截取每个中文的首字母
        if (needStr.length) {
            needStr = [needStr stringByAppendingFormat:@"%@", pinYin];
        }else {
            needStr = pinYin;
        }
    }
    
    return needStr;
}

//将中文字符串数组转换成中文拼音首字母字符串数组
+ (NSMutableArray *)convertChineseStringToPinyinWithArray:(NSArray *)array uppercaseString:(BOOL)isUp {
    if (!array.count) return nil;
    NSMutableArray *needArr = [NSMutableArray array];
    
    for (NSString *aString in array) {
        
        NSString *needStr = nil;
        for (int i=0; i<aString.length; i++) {
            //截取一个中文
            NSString *singleStr = [aString substringWithRange:NSMakeRange(i, 1)];
            //转成了可变字符串
            NSMutableString *str = [NSMutableString stringWithString:singleStr];
            //先转换为带声调的拼音
            CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
            //再转换为不带声调的拼音
            CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
            
            //转化为大写拼音
            NSString *pinYin = nil;
            if (isUp) {
                pinYin = [str capitalizedString];
            }else {
                pinYin = [str lowercaseString];
            }
            
            //截取每个中文的首字母
            if (needStr.length) {
                needStr = [needStr stringByAppendingFormat:@"%@", [pinYin substringToIndex:1]];
            }else {
                needStr = [pinYin substringToIndex:1];
            }
        }
        
        //字符串中每个中文的首字母 组合成 拼音字符串 加到数组中
        if (needStr != nil) {
            [needArr addObject:needStr];
        }
    }
    
    return needArr;
}

//按字母或数字顺序排序
+ (NSArray *)sortWithArray:(NSArray *)array orderAscending:(BOOL)isAscending{
    
    if (!array.count) return nil;
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (isAscending) {
            return [obj1 compare:obj2 options:NSNumericSearch];//升序
        }else {
            return [obj2 compare:obj1 options:NSNumericSearch];//降序
        }
    }];
    
    return sortedArray;
}

#pragma mark - 生成随机数
//随机生成num个字母或数字
/*
 通过arc4random()
 1 - 获取0到x-1之间的整数的代码如下：
 int value = arc4random() % x;
 
 2 - 获取1到x之间的整数的代码如下:
 int value = (arc4random() % x) + 1;
 */
+ (NSString *)randomStringWithNumber:(NSInteger)num{
    if (num < 0) return nil;
    
    char data[num];
    int type = arc4random()%3;
    
    if (type == 0) {
        for (int x=0;x<num;data[x++] = (char)('0' + (arc4random_uniform(10))));
    }
    else  if (type == 1) {
        for (int x=0;x<num;data[x++] = (char)('a' + (arc4random_uniform(26))));
    }
    else if (type == 2) {
        for (int x=0;x<num;data[x++] = (char)('A' + (arc4random_uniform(26))));
    }
    
    return [[NSString alloc] initWithBytes:data length:num encoding:NSUTF8StringEncoding];
}

#pragma mark - 加逗号
+ (NSString *)addCommaInString:(NSString *)content {
    content = [NSString stringWithFormat:@"%@", content];
    
    if (!IS_BLANK_STRING(content)) {
        NSString *needStr = [self countNumAndChangeformat:content];
        return needStr;
    }
    else {
        return content;
    }
}

+ (NSString *)countNumAndChangeformat:(NSString *)content{
    NSString *subStr = nil, *preStr = nil;
    
    for (int i=0; i<content.length; i++) {
        NSString *temp = [content substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"."]) { //有小数点
            subStr = [content substringFromIndex:i];
            preStr = [content substringWithRange:NSMakeRange(0, i)];
            break;
        }
    }
    
    if (!preStr) { //没有小数点
        preStr = content;
        subStr = @"";
    }
    
    int count = 0;
    long long int a = preStr.longLongValue;
    while (a != 0)    {
        count++;
        a /= 10;
    }
    
    NSMutableString *string = [NSMutableString stringWithString:preStr];
    NSMutableString *newstring = [NSMutableString string];
    
    while (count > 3) {
        count -= 3;
        
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        
        [string deleteCharactersInRange:rang];
    }
    
    [newstring insertString:string atIndex:0];
    
    return [NSString stringWithFormat:@"%@%@", newstring, subStr];
}

#pragma mark - 判断一个字符串是否包含另一个字符串
+ (BOOL)str:(NSString *)str isContainString:(NSString *)str1 {
    BOOL flag = NO;
    
    if (FSystemVersion >= 8.0) {
        if ([str containsString:str1]) {
            flag = YES;
        }
    }
    else {
        NSRange range = [str rangeOfString:str1];
        if (range.location != NSNotFound) {
            flag = YES;
        }
    }
    
    return flag;
}

#pragma mark - 获取字符串中的数字
- (NSString *)getNumberFromStr:(NSString *)str {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    //NSLog(@"%@", [self getNumberFromStr:@"a0b0c1d2e3f4fda8fa8fad9fsad23"]); // 00123488923
    
    return [[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

#pragma mark - 移除字符串中的空格和换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return temp;
}

#pragma mark - 其他

@end
