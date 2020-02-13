//
//  XXZTabBar.h
//  Zachary
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXZTabBarButton.h"

@class XXZTabBar;

@protocol XXZTabBarDelegate <NSObject>

/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(XXZTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface XXZTabBar : UIView

@property (nonatomic, weak) id<XXZTabBarDelegate>delegate;

/**
 *  使用特定图片来创建按钮, 可扩展性
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;

//自定义TabBar的按钮点击事件
- (void)clickBtn:(XXZTabBarButton *)button;

@end
