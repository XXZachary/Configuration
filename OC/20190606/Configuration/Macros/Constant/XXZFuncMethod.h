//
//  XXZFuncMethod.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#ifndef XXZFuncMethod_h
#define XXZFuncMethod_h

/* ***************************************************** */
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE_FILE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

/* ***************************************************** */
// View 圆角
#define ViewRadius(View, Radius)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];

// View 四周阴影
#define ViewShadow(view, shadowOpacity, shadowColor, shadowRadius, shadowOffset)\
[view.layer setShadowOpacity:shadowOpacity]; \
[view.layer setShadowColor:shadowColor.CGColor]; \
[view.layer setShadowRadius:shadowRadius]; \
[view.layer setShadowOffset:shadowOffset];\

/* ***************************************************** */
// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

/* ***************************************************** */
#define BEYOND_IOS7 (FSystemVersion >= 7.0) //iOS 7 以上(含)
#define BELOW_IOS7 (FSystemVersion < 7.0)//iOS 7 以下(不含)
#define IS_iPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) // 是否iPad

//当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])
//格式化字符串
#define FORMAT(agr, ...)      [NSString stringWithFormat:agr, ## __VA_ARGS__]

/* ***************************************************** */
// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// 是否iPhone4 系列
#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5 系列
#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否是iPhone6 系列
#define isiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(750, 1334), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否是iPhone6p 系列
#define isiPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(1242, 2208), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否是iPhone X 系列
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(1125, 2436), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

/* ***************************************************** */
// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

/* ***************************************************** */
//沙盒路径
#define PATH_OF_APP_HOME     NSHomeDirectory()
#define PATH_OF_TEMP                NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
                                                          NSUserDomainMask, YES) objectAtIndex:0]
//alert view  iOS < 8.0
#define SHOW_ALERT(msg) \
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil \
message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alertView show];

#define SHOW_ALERT_SURE(msg) \
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil \
message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];\
[alertView show];

/* ***************************************************** */
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


/* ***************************************************** */


#endif /* XXZMethod_h */
