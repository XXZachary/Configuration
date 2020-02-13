//
//  TUtility.m
//  TOUCH
//
//  Created by 王欢 on 15/10/19.
//  Copyright (c) 2015年 CNWH. All rights reserved.
//

#import "TUtility.h"
#import "AppDelegate.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#include <sys/xattr.h>
#include <sys/sysctl.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>

#define Iphone1      @"Iphone1"
#define Iphone3G     @"Iphone3G"
#define Iphone3GS    @"Iphone3GS"
#define Iphone4      @"Iphone4"
#define Iphone4S     @"Iphone4S"
#define Iphone5      @"Iphone5"
#define Iphone6      @"Iphone6"
#define Iphone6p     @"Iphone6p"

#define IpodTouch1   @"IpodTouch1"
#define IpodTouch2   @"IpodTouch2"
#define IpodTouch3   @"IpodTouch3"
#define IpodTouch4   @"IpodTouch4"
#define IpodTouch5   @"IpodTouch5"

#define Simulate     @"Simulate"

@implementation TUtility

+ (TUtility *)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *) machine
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    return platform;
}

- (NSString *) platform
{
    
    NSString *platform = [[TUtility sharedManager] machine];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

- (NSString *) platformString
{
    NSString *platform = [[TUtility sharedManager] platform];
    if ([platform isEqualToString:@"iPhone 2G"]) return Iphone1;
    if ([platform isEqualToString:@"iPhone 3G"]) return Iphone3G;
    if ([platform isEqualToString:@"iPhone 3GS"]) return Iphone3GS;
    if ([platform isEqualToString:@"iPhone 4"] || [platform isEqualToString:@"iPhone 4 (CDMA)"]) return Iphone4;
    if ([platform isEqualToString:@"iPhone 4S"]) return Iphone4S;
    if ([platform isEqualToString:@"iPhone 5"] || [platform isEqualToString:@"iPhone 5 (GSM+CDMA)"]) return Iphone5;
    if ([platform isEqualToString:@"iPhone 6"] || [platform isEqualToString:@"iPhone 6 (GSM+CDMA)"]) return Iphone6;
    
    if ([platform isEqualToString:@"iPod Touch (1 Gen)"])   return IpodTouch1;
    if ([platform isEqualToString:@"iPod Touch (2 Gen)"])   return IpodTouch2;
    if ([platform isEqualToString:@"iPod Touch (3 Gen)"])   return IpodTouch3;
    if ([platform isEqualToString:@"iPod Touch (4 Gen)"])   return IpodTouch4;
    if ([platform isEqualToString:@"iPod Touch (5 Gen)"])   return IpodTouch5;
    
    if ([platform isEqualToString:@"Simulator"])   return Simulate;
    return platform;
}


- (UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL time:(CMTime)tm
{
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CGImageRef imgRef = [generator copyCGImageAtTime:tm actualTime:NULL error:&err];
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    
    return theImage;
}

+(NSString*)nsdateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}

//显示时间间隔
+(NSString*)createShowTime:(NSString*)showTime{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[showTime doubleValue]];
    NSInteger diff =  -[confromTimesp timeIntervalSinceNow];
    
    if(diff/60>0){
        diff /=60;
        if (diff/60>0) {
            diff/=60;
            if (diff/24>0) {
                diff/=24;
                if (diff/30>0) {
                    diff/=30;
                    if (diff/12>0) {
                        diff/=12;
                        return [NSString stringWithFormat:@"%ldy",(long)diff];
                    }
                    return [NSString stringWithFormat:@"%ldm",(long)diff];
                }
                return [NSString stringWithFormat:@"%ldd",(long)diff];
            }
            return [NSString stringWithFormat:@"%ldh",(long)diff];
        }
        return [NSString stringWithFormat:@"%ldm",(long)diff];
    }
    
    return [NSString stringWithFormat:@"%lds",(long)diff];
}

//根据指定的颜色字体显示局部字体样子
+(NSMutableAttributedString *)createArrtibutedString:(NSMutableAttributedString *)source
                                               color:(UIColor *)textColor
                                          colorRange:(NSRange)colorRange
                                           rangeFont:(UIFont *)rangeFont
                                          rangeRange:(NSRange)rangeRange
{
    [source addAttribute:NSForegroundColorAttributeName value:textColor range:colorRange];
    [source addAttribute:NSFontAttributeName value:rangeFont range:rangeRange];
    return source;
}

//调用系统分享
+ (void)shareBySystem:(NSString *)message
                  url:(NSString *)urlString
                image:(UIImage *)uiimage
                 view:(UIImage *)view
                  nav:(UINavigationController *)navigation
{
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[message, urlString]
                                      applicationActivities:nil];
    [navigation presentViewController:activityViewController animated:YES completion:^{
        
    }];
}


+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
	//原始图片
//	UIImage *image = image;

//CIImage 获取图片资源
	CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];

//CIFilter 滤镜
	CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];

//将图片输入到滤镜中
	[blurFilter setValue:ciImage forKey:kCIInputImageKey];

//设置模糊程度 默认10
	[blurFilter setValue:@(10) forKey:@"inputRadius"];

//将处理好的图片输出
	CIImage *outCiImage = [blurFilter valueForKey:kCIOutputImageKey];

//用来查询滤镜可以设置的参数和相关的信息
	XXZLog(@"in blurryImage ...... attributes is %@",[blurFilter attributes]);

//CIContext
	CIContext *context = [CIContext contextWithOptions:nil];

//获取CGImage句柄
	CGRect extent = CGRectInset(CGRectMake(0,0,image.size.width,image.size.height), 10, 10);
	CGImageRef outCGImage = [context createCGImage:outCiImage fromRect:extent];

//最终获取到图片
	UIImage *blurImage = [UIImage imageWithCGImage:outCGImage];

//释放CGImage句柄
	CGImageRelease(outCGImage);

	return blurImage;
}

@end
