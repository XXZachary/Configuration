//
//  CallMobileModel.m
//  Easy2Car
//
//  Created by Zachary on 2018/9/13.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import "CallMobileModel.h"

@implementation CallMobileModel

+ (void)callMobile:(NSString *)mobile view:(UIView *)view {
    if (view == nil) {
        view = KEY_WINDOW;
    }
    
    if (IS_BLANK_STRING(mobile) || ![XXZSRegularClass isMobilePhoneWithNum:mobile]) {
        [MBProgressHUD showMsg:@"无效手机号码" toView:view];
        return;
    }
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}

@end
