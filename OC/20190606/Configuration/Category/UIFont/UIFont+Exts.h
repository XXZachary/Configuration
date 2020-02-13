//
//  UIFont+Exts.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/6/6.
//  Copyright © 2019 www.xxzachary.com. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Exts)

/**极端轻*/
+ (UIFont *)ultraLight:(CGFloat)weight;
/**瘦*/
+ (UIFont *)thin:(CGFloat)weight;
/**轻*/
+ (UIFont *)light:(CGFloat)weight;
/**规则, 即默认*/
+ (UIFont *)regular:(CGFloat)weight;
/**中等*/
+ (UIFont *)medium:(CGFloat)weight;
/**半粗体*/
+ (UIFont *)semibold:(CGFloat)weight;
/**粗体*/
+ (UIFont *)bold:(CGFloat)weight;
/**重粗*/
+ (UIFont *)heavy:(CGFloat)weight;
/**黑体*/
+ (UIFont *)black:(CGFloat)weight;
/**斜体*/
+ (UIFont *)italic:(CGFloat)weight;

@end

NS_ASSUME_NONNULL_END
