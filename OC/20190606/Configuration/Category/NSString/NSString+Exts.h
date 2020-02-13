//
//  NSString+Exts.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/6/6.
//  Copyright © 2019 www.xxzachary.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Exts)

//判断字符串是否为空
- (NSString *)stringIsEmpty;
//判断对象是否为空
- (BOOL)objectIsEmpty:(id)object;
/**
 * mode: 四舍五入, 只舍不入, 只入不舍
 *position: 有效数字位数
 */
- (NSString *)rounding:(NSRoundingMode)mode afterPoint:(int)position;

@end

NS_ASSUME_NONNULL_END
