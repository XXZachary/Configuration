//
//  StoryNavDelegate.m
//  CategoryDemo
//
//  Created by Zachary on 15/10/8.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import "StoryNavDelegate.h"
#import "Animator.h"

@interface StoryNavDelegate () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@property (strong, nonatomic) Animator* animator;

@end

@implementation StoryNavDelegate

- (void)awakeFromNib {
    [self initWithData];
}

- (void)initWithData {
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
    
    self.animator = [Animator new];
    //    self.animator.animateType = Two;
}

- (void)pan:(UIPanGestureRecognizer*)recognizer {
    UIView* view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        //右滑返回的区域,但无方向限制
        CGPoint location = [recognizer locationInView:view];
        
        if (location.x <  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) { // left half
            
            //        if (self.navigationController.viewControllers.count > 1) {
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        self.animator.animateType = ATRotation;
        return self.animator;
    }
    
    if (operation == UINavigationControllerOperationPush) {
        self.animator.animateType = ATScale;
        return self.animator;
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactionController;
}

@end
