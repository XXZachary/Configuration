//
//  AppDelegate+Login.m
//  Zachary
//
//  Created by Zachary on 2018/8/31.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import "AppDelegate+Login.h"
#import "XXZTabBarController.h"

#import "MainViewController.h"
#import "AppointViewController.h"
#import "MineViewController.h"

#import "LoginViewController.h"

@implementation AppDelegate (Login)

- (void)switchAppHome {
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUND];
        self.window.backgroundColor = WHITE_COLOR;
    }
    
    MainViewController *main = [[MainViewController alloc] init];
    XXZNavigationController *mainNav = [[XXZNavigationController alloc] initWithRootViewController:main];
    
    AppointViewController *appoint = [[AppointViewController alloc] init];
    XXZNavigationController *appointNav = [[XXZNavigationController alloc] initWithRootViewController:appoint];
    
    MineViewController *mine = [[MineViewController alloc] init];
    XXZNavigationController *mineNav = [[XXZNavigationController alloc] initWithRootViewController:mine];
    
    XXZTabBarController *tab = [[XXZTabBarController alloc] init];
    tab.viewControllers = @[mainNav, appointNav, mineNav];
    
    //过渡
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = tab;
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
    
    [self.window makeKeyAndVisible];
}

- (void)switchAppLogin {
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUND];
        self.window.backgroundColor = WHITE_COLOR;
    }
    
    LoginViewController *login = [[LoginViewController alloc] init];
    XXZNavigationController *loginNav = [[XXZNavigationController alloc] initWithRootViewController:login];
    
    //过渡
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = loginNav;
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
    
    [self.window makeKeyAndVisible];
}

- (void)switchAppLogout {
    
}

#pragma mark - Zachary -
// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController {
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self.window.rootViewController;
    }
    else if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectVc = [((UITabBarController *)self.window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)selectVc;
        }
    }
    
    return nil;
}

@end
