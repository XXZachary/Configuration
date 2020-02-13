//
//  MBProgressHUD+Json.m
//  SLifeX
//
//  Created by Slife on 2019/8/15.
//  Copyright © 2019 slife. All rights reserved.
//

#import "MBProgressHUD+Json.h"
#import "LOTAnimationView.h"

@implementation MBProgressHUD (Json)

+ (void)showJsonToView:(UIView *)view{
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！
    if (view == nil) view = KEY_WINDOW;
    view.userInteractionEnabled = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"refresh_header"];
    animation.backgroundColor = WhiteColor;
//    animation.frame = CGRectMake(0, 0, 100, 100);
//    animation.center = hud.center;
    animation.loopAnimation = YES;
    //    animation.autoReverseAnimation = YES;
    //    animation.animationSpeed = 2.4;
    [animation play];
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置方框view背景色
    hud.bezelView.backgroundColor = WhiteColor;
    //设置总背景view的背景色，并带有透明效果
    hud.customView = animation;
    
    hud.frame = CGRectMake(0, 0, 180, 180);
    hud.center = view.center;
    hud.backgroundColor = ClearColor;
    hud.customView.backgroundColor = ClearColor;
//    cusImageV.backgroundColor = ClearColor;
    hud.margin = 0;
    ViewShadow(hud, 0.5, [BlackColor colorWithAlphaComponent:0.4], 20, CGSizeMake(0, 0));
}

+ (void)hideJsonHUDForView:(UIView *)view {
    if (view == nil) view = KEY_WINDOW;
    view.userInteractionEnabled = YES;
    [self hideHUDForView:view animated:NO];
}

+ (void)hideJsonHUD {
    [self hideJsonHUDForView:nil];
}

@end
