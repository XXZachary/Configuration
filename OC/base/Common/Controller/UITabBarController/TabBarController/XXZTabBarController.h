//
//  XXZTabBarController.h
//  Zachary
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXZTabBar.h"

@interface XXZTabBarController : UITabBarController

@property (nonatomic, strong) XXZTabBar *tabBarView;
@property (nonatomic) BOOL hidesBottomBarWhenPushed;

@end
