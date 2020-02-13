//
//  UIWebView+JavaScriptAlert.h
//  Saas
//
//  Created by Jiayu_Zachary on 16/4/14.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScriptAlert)

// js 中 alert 提示
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

// js 中 confirm 提示
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

- (NSString *)webView:(UIWebView *)view runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)text initiatedByFrame:(id)frame;

@end
