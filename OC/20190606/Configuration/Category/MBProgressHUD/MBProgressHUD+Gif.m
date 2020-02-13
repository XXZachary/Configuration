//
//  MBProgressHUD+Gif.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/5/27.
//  Copyright © 2019 com.xxzing.future. All rights reserved.
//

#import "MBProgressHUD+Gif.h"

@implementation MBProgressHUD (Gif)

+ (void)showGifToView:(UIView *)view{
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！
    if (view == nil) view = KEY_WINDOW;
    view.userInteractionEnabled = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
     FLAnimatedImageView *cusImageV = [[FLAnimatedImageView alloc] init];
    cusImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"loading_120120" withExtension:@"gif"];
    FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfURL:imgUrl]];
    cusImageV.animatedImage = image;
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置方框view背景色
    hud.bezelView.backgroundColor = WhiteColor;
    //设置总背景view的背景色，并带有透明效果
    hud.customView = cusImageV;
    
    hud.frame = CGRectMake(0, 0, 180, 180);
    hud.center = view.center;
    hud.backgroundColor = ClearColor;
    hud.customView.backgroundColor = ClearColor;
    cusImageV.backgroundColor = ClearColor;
    hud.margin = 30;
    ViewShadow(hud, 0.5, [BlackColor colorWithAlphaComponent:0.4], 20, CGSizeMake(0, 0));
}

+ (void)hideGifHUDForView:(UIView *)view {
    if (view == nil) view = KEY_WINDOW;
    view.userInteractionEnabled = YES;
    [self hideHUDForView:view animated:NO];
}

+ (void)hideGifHUD {
    [self hideGifHUDForView:nil];
}


@end
