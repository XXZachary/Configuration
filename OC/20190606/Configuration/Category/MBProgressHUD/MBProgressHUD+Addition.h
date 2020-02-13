//
//  MBProgressHUD+Addition.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/4/10.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Addition)

/**
 *  显示错误信息,1秒之后再消失
 *
 *  @param errorMsg 错误信息
 *  @param view     显示的view
 */
+ (void)showError:(NSString *)errorMsg toView:(UIView *)view;

/**
 *  显示正确信息,1秒之后再消失
 *
 *  @param successMsg 成功的信息
 *  @param view       显示的view
 */
+ (void)showSuccess:(NSString *)successMsg toView:(UIView *)view;

/**
 *  显示回调信息,1秒之后再消失
 *
 *  @param msg  提示信息
 *  @param view 显示的view
 */
+ (void)showMsg:(NSString *)msg toView:(UIView *)view;

/**
 *  显示一些信息,需手动设置消失提示框
 *
 *  @param msg  提示信息
 *  @param view 显示的view
 *
 *  @return 提示的对象
 */
+ (MBProgressHUD *)showMessage:(NSString *)msg toView:(UIView *)view;

@end
