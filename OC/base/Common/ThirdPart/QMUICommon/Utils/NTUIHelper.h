//
//  QDUIHelper.h
//  qmuidemo
//
//  Created by ZhoonChen on 15/6/2.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTUIHelper : NSObject

+ (void)forceInterfaceOrientationPortrait;

#pragma mark - 通讯框

/**
 呈现loading
 
 @param text 要呈现的文字
 */
+ (void)showLoadingWithText:(NSString*)text;

/**
 移除loading
 
 @param type 0：直接移除 1：呈现成功消息 2：呈现失败消息 3：呈现提示消息
 @param text 呈现消息
 */
+ (void)hideLoadingWithType:(NSInteger)type andText:(NSString*)text;

@end


@interface NTUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;

@end


@interface NTUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;

@end


@interface NTUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end


@interface NTUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;

@end


@interface NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *codeString, NSRange codeRange))block;

@end


@interface NTUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied;

@end


@interface NTUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;
    
@end


@interface NTUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color;
@end
