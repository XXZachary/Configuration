//
//  BasePopView.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/9/10.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePopView : UIView

@property (nonatomic, strong) UIView *maskView;

- (void)showAnimated;
- (void)hiddenAnimated;

- (void)showAlpha;
- (void)hiddenAlpha;

@end
