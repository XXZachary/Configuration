//
//  XXZImageColor.h
//  UICollectionVIewDemo
//
//  Created by Zachary on 2017/7/11.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XZGradientType) {
    XZGradientTypeTopToBottom,
    XZGradientTypeLeftToRight,
    XZGradientTypeLeftToRightBottom,
    XZGradientTypeRightToLeftBottom
};

@interface XXZImageColor : NSObject

#pragma mark - custom
/**随机颜色*/
+ (UIColor *)colorByRandom;

/**颜色转图片*/
+ (UIImage *)imageByColor:(UIColor *)color size:(CGSize)size;

/**渐变颜色生成UIImage*/
+ (UIImage *)imageByGradientColor:(NSMutableArray <UIColor *> *)colors gradientType:(XZGradientType)gradientType size:(CGSize)size;

/**UIImage拉伸*/
+ (UIImage *)imageByStretchable:(UIImage *)image;

/**UIImage的alpha*/
+ (UIImage*)imageByAlpha:(CGFloat)alpha image:(UIImage *)image;

/**裁剪图片, 但图片可能会被拉伸*/
+ (UIImage *)imageByCut:(UIImage *)image size:(CGSize)size;

#pragma mark - specific
//通过图片Data数据第一个字节 来获取图片扩展名*/
+ (NSString *)contentTypeForImageData:(NSData *)data;

/**
 *获取一个视频的第一帧图片
 *urlString 视频链接
 */
+ (UIImage *)videoWithFirstFps:(NSString *)urlString;

//获取视频的时长
+ (NSInteger)getVideoTimeByUrlString:(NSString *)urlString;

/**比较两个颜色是否相等*/
- (BOOL)color:(UIColor *)color isEqualToColor:(UIColor *)otherColor;

@end
