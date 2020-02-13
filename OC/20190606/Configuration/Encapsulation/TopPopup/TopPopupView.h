//
//  TopPopupView.h
//  SLifeX
//
//  Created by Slife on 2019/8/8.
//  Copyright © 2019 slife. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopPopupView : UIView

//返回实体, 不自动隐藏
+ (TopPopupView *)popup:(NSString *)msg toView:(nullable UIView *)view;
//2.5s后自动隐藏
+ (void)pop:(NSString *)msg toView:(nullable UIView *)view;

- (void)showAnimated; //顶部划入
- (void)hiddenAnimated; //顶部滑出

//去掉小数点后面无用的0
+ (NSString *)minusDigital:(double)digital;
+ (NSString *)minusDigitalString:(NSString *)digital;

//时间戳 转 年/月/日
+ (NSString *)timestamp:(NSTimeInterval)timestamp;

//去掉d小数点后面无用的0, 默认取6位有效数字
+ (NSString *)cutUseless:(double)digital :(int)bit;

@end

NS_ASSUME_NONNULL_END
