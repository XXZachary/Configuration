//
//  UIView+Extension.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 边框方向
 - WZBBorderDirectionTop: 顶部
 - WZBBorderDirectionLeft: 左边
 - WZBBorderDirectionBottom: 底部
 - WZBBorderDirectionRight: 右边
 */
typedef NS_ENUM(NSInteger, WZBBorderDirectionType) {
    WZBBorderDirectionTop = 0,
    WZBBorderDirectionLeft,
    WZBBorderDirectionBottom,
    WZBBorderDirectionRight
};

@interface UIView (Exts)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

/**
 *为UIView的某个方向添加边框
 *
 *param direction 边框方向
 *param color 边框颜色
 *param width 边框宽度
 *
 */
- (void)wzb_addBorder:(WZBBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width;

@end
