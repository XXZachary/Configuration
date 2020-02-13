//
//  Animator.m
//  CategoryDemo
//
//  Created by Zachary on 15/10/8.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import "Animator.h"

@implementation Animator

//动画时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

//动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    
    if (_animateType == ATScale) {
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }else if (_animateType == ATRotation) {
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            fromViewController.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            
            
            //            fromViewController.view.transform = CGAffineTransformMakeTranslation(1, 1);
            //            fromViewController.view.transform = CGAffineTransformMake(1, 1, 1, 1, 1, 1);
            
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }else if (_animateType == Three) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            CALayer *layer = [CALayer layer];
            //旋转动画
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            //这里是以向量(1, 1, 0)为轴，旋转π/2弧度(90&deg;)
            //如果只是在手机平面上旋转，就设置向量为(0, 0, 1)，即Z轴
            anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 1, 1, 0)];
            anim.duration = 1;
            [layer addAnimation:anim forKey:nil];
            
            toViewController.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //            fromViewController.view.transform = CGAffineTransformMake(1, 1, 1, 1, 1, 1);
            //
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}

@end
