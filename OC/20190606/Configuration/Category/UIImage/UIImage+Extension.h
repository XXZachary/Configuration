//
//  UIImage+Extension.h
//  Easy2Car
//
//  Created by H_Dani on 2018/10/11.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)


/**
 等比例缩小 放大图片

 @param sourceImage 图片
 @param size 大小
 @return 返回图片
 */
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (UIImage *)stretchableImage:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
