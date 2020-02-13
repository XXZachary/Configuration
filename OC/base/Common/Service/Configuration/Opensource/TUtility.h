//
//  TUtility.h
//  TOUCH
//
//  Created by 王欢 on 15/10/19.
//  Copyright (c) 2015年 CNWH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>

@interface TUtility : NSObject

+ (TUtility *)sharedManager;


///////// 设备信息 ///////////
- (NSString *) platformString;
- (NSString *) platform;
//获取截图
- (UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL time:(CMTime)tm;

+(NSString*)nsdateToString:(NSDate *)date;
//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString;
//显示时间间隔
+(NSString*)createShowTime:(NSString*)showTime;
//根据指定的颜色字体显示局部字体样子
+(NSMutableAttributedString *)createArrtibutedString:(NSMutableAttributedString *)source
                                               color:(UIColor *)textColor
                                          colorRange:(NSRange)colorRange
                                           rangeFont:(UIFont *)rangeFont
                                          rangeRange:(NSRange)rangeRange;
//调用系统分享
+ (void)shareBySystem:(NSString *)message
                  url:(NSString *)urlString
                image:(UIImage *)uiimage
                 view:(UIImage *)view
                nav:(UINavigationController *)navigation;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end

