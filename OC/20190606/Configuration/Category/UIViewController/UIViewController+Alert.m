//
//  UIViewController+Alert.m
//  AnimatedDemo
//
//  Created by Zachary on 2018/3/1.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import "UIViewController+Alert.h"
#import <objc/runtime.h>

@implementation UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)mesasge cancelTitle:(NSString *)cancelTitle otherTitle:(NSArray<NSString *> *)otherTitleArr cancel:(CancelBlock)cancel other:(OtherBlock)other {
    if (!cancelTitle.length && !otherTitleArr.count) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:mesasge preferredStyle:[self.isSheet boolValue] ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert];
    
    //取消
    if (cancelTitle.length) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancel();
        }];
        [alert addAction:action1];
    }
    
    //其他
    if (otherTitleArr.count) {
        void (^addOtherAction) (NSString *title, NSInteger index) = ^(NSString *title, NSInteger index) {
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                other(index);
            }];
            [alert addAction:action2];
        };
        
        for (int i=0; i<otherTitleArr.count; i++) {
            id otherTitle = otherTitleArr[i];
            if (![otherTitle isKindOfClass:[NSString class]]) {
                continue;
            }
            
            addOtherAction(otherTitle, i);
            
            //            UIAlertAction *action2 = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                other(i);
            //            }];
            //            [alert addAction:action2];
        }
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)mesasge cancelTitle:(NSString *)cancelTitle otherTitle:(NSArray<NSString *> *)otherTitleArr cancel:(CancelBlock)cancel other:(OtherBlock)other {
    if (!cancelTitle.length && !otherTitleArr.count) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:mesasge preferredStyle:[self.isSheet boolValue] ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    
    //取消
    if (cancelTitle.length) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancel();
        }];
        [alert addAction:action1];
    }
    
    //其他
    if (otherTitleArr.count) {
        //        void (^addOtherAction) (NSString *title, NSInteger index) = ^(NSString *title, NSInteger index) {
        //            UIAlertAction *action2 = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //                other(index);
        //            }];
        //            [alert addAction:action2];
        //        };
        
        for (int i=0; i<otherTitleArr.count; i++) {
            id otherTitle = otherTitleArr[i];
            if (![otherTitle isKindOfClass:[NSString class]]) {
                continue;
            }
            
            //            addOtherAction(otherTitle, i);
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                other(i);
            }];
            [alert addAction:action2];
        }
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - associate
- (void)setIsSheet:(NSNumber *)isSheet {
    objc_setAssociatedObject(self, @selector(isSheet), isSheet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)isSheet {
    return objc_getAssociatedObject(self, @selector(isSheet));
}

@end
