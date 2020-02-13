//
//  QDUIHelper.m
//  qmuidemo
//
//  Created by ZhoonChen on 15/6/2.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import "NTUIHelper.h"

@implementation NTUIHelper

+ (void)forceInterfaceOrientationPortrait {
    if ([[UIDevice currentDevice] orientation] != UIDeviceOrientationPortrait) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
}

/**
 呈现loading
 
 @param text 要呈现的文字
 */
+ (void)showLoadingWithText:(NSString*)text{

    if (!text) {
        text = @"连接中";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [QMUITips hideAllToastInView:window animated:YES];
        [QMUITips showLoading:text inView:window];
        
    });
}

/**
 移除loading

 @param type 0：直接移除 1：呈现成功消息 2：呈现失败消息 3：呈现提示消息
 @param text 呈现消息
 */
+ (void)hideLoadingWithType:(NSInteger)type andText:(NSString*)text{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [QMUITips hideAllToastInView:window animated:YES];

        if (type == 1) {
            //成功
            [QMUITips showSucceed:text inView:window hideAfterDelay:1.5];
        }else if (type == 2){
            //失败
            [QMUITips showError:text inView:window hideAfterDelay:1.5];
        }else if (type == 3){
            //提示
            [QMUITips showInfo:text inView:window hideAfterDelay:1.5];
        }
    });
}

@end


@implementation NTUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance {
    // 如果需要统一修改全局的 QMUIMoreOperationController 样式，在这里修改 appearance 的值即可
}

@end


@implementation NTUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance {
    // 如果需要统一修改全局的 QMUIAlertController 样式，在这里修改 appearance 的值即可
}

@end


@implementation NTUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    return tabBarItem;
}

@end


@implementation NTUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton {
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    button.highlightedBackgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorBlack progress:.15];// 高亮时的背景色
    button.layer.cornerRadius = 4;
    return button;
}

+ (QMUIButton *)generateLightBorderedButton {
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor forState:UIControlStateNormal];
    button.backgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorWhite progress:.9];
    button.highlightedBackgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorWhite progress:.75];// 高亮时的背景色
    button.layer.borderColor = [button.backgroundColor qmui_transitionToColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor progress:.5].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 4;
    button.highlightedBorderColor = [button.backgroundColor qmui_transitionToColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor progress:.9];// 高亮时的边框颜色
    return button;
}

@end


@implementation NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *, NSRange))block {
    NSString *pattern = @"\\[?[A-Za-z0-9_.]+\\s?[A-Za-z0-9_:.]+\\]?";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result.range.length > 0) {
            if (block) {
                block([self substringWithRange:result.range], result.range);
            }
        }
    }];
}

@end


@implementation NTUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied {
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"无法保存" message:@"你未开启“允许 QMUI 访问照片”选项" preferredStyle:QMUIAlertControllerStyleAlert];
    
    QMUIAlertAction *settingAction = [QMUIAlertAction actionWithTitle:@"去设置" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        NSURL *url = [[NSURL alloc] initWithString:@"prefs:root=Privacy&path=PHOTOS"];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:settingAction];
    
    QMUIAlertAction *okAction = [QMUIAlertAction actionWithTitle:@"我知道了" style:QMUIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    
    [alertController showWithAnimated:YES];
}

@end


@implementation NTUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size {
    NSString * strSize = nil;
    if (size >= 1048576.0) {
        strSize = [NSString stringWithFormat:@"%.2fM", size / 1048576.0f];
    } else if (size >= 1024.0) {
        strSize = [NSString stringWithFormat:@"%.2fK", size / 1024.0f];
    } else {
        strSize = [NSString stringWithFormat:@"%.2fB", size / 1.0f];
    }
    return strSize;
}

@end


@implementation NTUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color {
    CGSize size = CGSizeMake(4, 64);
    UIImage *resultImage = nil;
    color = color ? color : UIColorClear;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (CFArrayRef)@[(id)color.CGColor, (id)[color qmui_colorWithAlphaAddedToWhite:.86].CGColor], NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, size.height), kCGGradientDrawsBeforeStartLocation);
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [resultImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
}

@end
