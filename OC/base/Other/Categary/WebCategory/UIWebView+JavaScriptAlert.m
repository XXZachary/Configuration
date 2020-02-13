//
//  UIWebView+JavaScriptAlert.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/4/14.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)

static BOOL status = NO;
static BOOL isEnd =NO;

// js 中 alert 提示
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
//    XXZLog(@"message = %@", message);
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [customAlert show];
}

- (NSString *) webView:(UIWebView *)view runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)text initiatedByFrame:(id)frame {
    return @"";
}

// js 中 confirm 提示
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [confirmDiag show];
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion]floatValue];
    if (version >= 7.) {
        while (isEnd ==NO) {
            [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
        }
    }
    else {
        while (isEnd ==NO && confirmDiag.superview !=nil) {
            [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
        }
    }
    
    isEnd = NO;
    return status;
}

//点击对应的事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    status = buttonIndex;
    isEnd = YES;
}

@end
