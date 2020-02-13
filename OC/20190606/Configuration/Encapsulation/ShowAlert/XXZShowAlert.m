//
//  ShowAlert.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "XXZShowAlert.h"

//NSString *const xAlertViewNotification = @"xAlertViewNotification";
//NSString *const xSheetActionNotification = @"xSheetActionNotification";

@implementation XXZShowAlert

- (instancetype)init {
    self = [super init];
    if (self) {
        //init..
    }
    return self;
}

#pragma mark - alert view
- (void)alertWithAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg okAction:(NSString *)okName {
    if (!vc) {
        return;
    }
    
    //判断是否有标题
    if (!title.length) {
        title = @"温馨提示";
        
        if (!msg.length) {
//            title = @"请输入提示语!";
            return;
        }
    }
    
    //1 - 创建弹窗管理器以及确定样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    //2 - 创建按钮
    //2.1 取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:xAlertViewNotification object:@(XXZButtonIndexCancel)];
        
        //coding..
        if ([_delegate respondsToSelector:@selector(alertViewWithAction:index:tag:)]) {
            [_delegate alertViewWithAction:action index:XXZButtonIndexCancel tag:_tag];
        }
        
        
    }];
    //将按钮加入管理器
    [alertController addAction:cancelAction];
    
    //2.2 确定按钮
    if (okName.length) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮响应的事件
//            [[NSNotificationCenter defaultCenter] postNotificationName:xAlertViewNotification object:@(XXZButtonIndexZero)];
            
            //coding..
            if ([_delegate respondsToSelector:@selector(alertViewWithAction:index:tag:)]) {
                [_delegate alertViewWithAction:action index:XXZButtonIndexZero tag:_tag];
            }
            
            
        }];
        //将按钮加入管理器
        [alertController addAction:okAction];
    }
    
    //3 - 将按钮加入管理器中;一般取消按钮在左边,否则异常
    
    //4 - 显示对话框视图控制器
    [vc presentViewController:alertController animated:YES completion:^{
//        //若只有"取消"按钮,设置时间间隔自动消失
//        if (!isHave) {
//            [self removeAlertWithViewController:vc];
//        }
    }];
}

//移除弹窗指示器
- (void)removeAlertWithViewController:(UIViewController *)vc {
    [self performSelector:@selector(removeAlertViewWithViewController:) withObject:vc afterDelay:2.0];
}

//移除提示框
- (void)removeAlertViewWithViewController:(UIViewController *)vc{
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - sheet action
- (void)alertWithActionSheet:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg action:(NSArray *)actionArray{
    if (!actionArray.count) {
        XXZLog(@"no action");
        return;
    }
    
    if (!vc) {
        return;
    }
    
    //判断是否有标题
    if (!title.length) title = @"请选择";
    
    //说明, 默认不需要说明
    if (msg.length) msg = nil;
    
    //1 - 创建弹窗管理器及样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2 - 创建按钮
    //2.1 取消事件
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击事件
//        [[NSNotificationCenter defaultCenter] postNotificationName:xSheetActionNotification object:@(XXZButtonIndexCancel)];
        
        //coding..
        if ([_delegate respondsToSelector:@selector(actionSheetWithAction:index:tag:)]) {
            [_delegate actionSheetWithAction:action index:XXZButtonIndexCancel tag:_tag];
        }
        
    }];
    
    //3 - 将取消按钮加入管理器中
    [alertController addAction:cancelAction];
    
    //2.2 事件按钮
    for (int i=0; i<actionArray.count; i++) {
        UIAlertAction *sheetAction = [UIAlertAction actionWithTitle:actionArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击事件
//            [[NSNotificationCenter defaultCenter] postNotificationName:xSheetActionNotification object:@(i)];
            
            //coding..
            if ([_delegate respondsToSelector:@selector(actionSheetWithAction:index:tag:)]) {
                [_delegate actionSheetWithAction:action index:i tag:_tag];
            }
            
        }];
        
        //3 - 将事件按钮加入管理器中
        [alertController addAction:sheetAction];
    }
    
    //3 - 将按钮加入管理器中
    //在创建是添加
    
    //4 - 推向对话框视图控制器
    [vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - setter
- (void)setTag:(NSInteger)tag {
    _tag = tag;
}

@end
