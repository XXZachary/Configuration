//
//  Animator.h
//  CategoryDemo
//
//  Created by Zachary on 15/10/8.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AnimateType) {
    ATScale,
    ATRotation,
    Three,
    ATDefault
};

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimateType animateType;

@end
