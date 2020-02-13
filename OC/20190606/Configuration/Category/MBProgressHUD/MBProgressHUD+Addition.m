//
//  MBProgressHUD+Addition.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/4/10.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "MBProgressHUD+Addition.h"

@implementation MBProgressHUD (Addition)

#pragma mark - 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.yOffset = -100;
    hud.label.text = text;
    
    if (icon.length) {
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark - 显示错误信息,1秒之后再消失
+ (void)showError:(NSString *)errorMsg toView:(UIView *)view{
    [self show:errorMsg icon:@"error.png" view:view];
}

#pragma mark - 显示正确信息,1秒之后再消失
+ (void)showSuccess:(NSString *)successMsg toView:(UIView *)view{
    [self show:successMsg icon:@"success.png" view:view];
}

#pragma mark - 显示回调信息,1秒之后再消失
+ (void)showMsg:(NSString *)msg toView:(UIView *)view {
    if (IS_BLANK_STRING(msg)) {
        return;
    }
    
    [self show:msg icon:nil view:view];
}

#pragma mark - 显示一些信息,不消失提示框
+ (MBProgressHUD *)showMessage:(NSString *)msg toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = msg;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    return hud;
}

@end
