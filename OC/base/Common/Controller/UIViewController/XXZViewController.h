//
//  XXZViewController.h
//  Zachary
//
//  Created by Zachary on 2017/4/12.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXZViewController : UIViewController

@property (nonatomic, assign) BOOL needHiddenBackButton;

- (void)showAlertWithTitle:(NSString *)title content:(NSString *)content action1Title:(NSString *)action1Title action2Title:(NSString *)action2Title action1Block:(void(^)(void))action1Block action2Block:(void(^)(void))action2Block;

//- (void)showQMUIAlertWithTitle:(NSString *)title content:(NSString *)content action1Title:(NSString *)action1Title action2Title:(NSString *)action2Title action1Block:(void (^)(void))action1Block action2Block:(void (^)(void))action2Block;

@end
